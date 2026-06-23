import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:url_launcher/url_launcher.dart';

class FolderFileItem extends StatefulWidget {
  final FileModel file;
  final bool isArabic;
  final int folderId;

  const FolderFileItem({
    super.key,
    required this.file,
    required this.isArabic,
    required this.folderId,
  });

  @override
  State<FolderFileItem> createState() => _FolderFileItemState();
}

class _FolderFileItemState extends State<FolderFileItem> {
  bool _hovered = false;
  bool _isDownloading = false;

  Future<void> _openFile() async {
    final String fullUrl =
        "${EndPoints.baseUrlToOpenFile}/${widget.file.filePath}";
    final Uri url = Uri.parse(fullUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _downloadFile(BuildContext context) async {
    setState(() => _isDownloading = true);

    String path = widget.file.filePath;
    if (widget.file.isFromAI && !path.startsWith('http')) {
      if (path.startsWith('/api/')) path = path.substring(5);
      if (path.startsWith('api/')) path = path.substring(4);
      path = '${EndPoints.baseUrlToOpenFile}/$path';

      // Fix fileType enum if it's stored as integer
      if (path.contains('fileType=1')) {
        path = path.replaceAll('fileType=1', 'fileType=Pdf');
      } else if (path.contains('fileType=0')) {
        path = path.replaceAll('fileType=0', 'fileType=Docx');
      }
    }

    final error = await FileDownloadHelper.downloadAndOpen(
      filePath: path,
      fileName: widget.file.fileName,
    );
    if (!mounted) return;
    setState(() => _isDownloading = false);
    if (error != null) {
      showSnackBar(context, error, AppColors.red);
    }
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final cubit = FolderFilesCubit.get(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) =>
          _DeleteConfirmationDialog(fileName: widget.file.fileName),
    );

    if (confirmed == true && context.mounted) {
      await cubit.deleteFile(folderId: widget.folderId, fileId: widget.file.id);
    }
  }

  Color get _typeColor {
    final t = widget.file.fileType.toLowerCase();
    if (t.contains('pdf')) return const Color(0xFFE53935);
    if (t.contains('doc') || t.contains('word')) return const Color(0xFF1E88E5);
    if (t.contains('png') || t.contains('jpg') || t.contains('image')) {
      return const Color(0xFF8E24AA);
    }
    if (t.contains('xls') || t.contains('xlsx') || t.contains('csv')) {
      return const Color(0xFF43A047);
    }
    return Colors.blueGrey;
  }

  IconData get _typeIcon {
    final t = widget.file.fileType.toLowerCase();
    if (t.contains('pdf')) return Icons.picture_as_pdf_rounded;
    if (t.contains('doc') || t.contains('word')) {
      return Icons.description_rounded;
    }
    if (t.contains('png') || t.contains('jpg') || t.contains('image')) {
      return Icons.image_rounded;
    }
    if (t.contains('xls') || t.contains('xlsx') || t.contains('csv')) {
      return Icons.table_chart_rounded;
    }
    return Icons.insert_drive_file_rounded;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () => _openFile(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.progressColor.withOpacity(0.06)
                : Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(
              color: _hovered
                  ? AppColors.progressColor.withOpacity(0.4)
                  : AppColors.greyLight.withOpacity(0.18),
            ),
            boxShadow: _hovered
                ? [
                    BoxShadow(
                      color: AppColors.progressColor.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Row(
            children: [
              // File type icon
              Container(
                width: 44.w,
                height: 44.h,
                decoration: BoxDecoration(
                  color: _typeColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(_typeIcon, color: _typeColor, size: 22.sp),
              ),
              SizedBox(width: 14.w),
              // File info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.file.fileName,
                      style: GoogleFonts.almarai(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      children: [
                        Text(
                          widget.file.fileSize,
                          style: GoogleFonts.almarai(
                            fontSize: 13.sp,
                            color: AppColors.greyLight,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(
                          width: 4.w,
                          height: 4.h,
                          decoration: const BoxDecoration(
                            color: AppColors.greyLight,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          widget.file.fileType.toUpperCase(),
                          style: GoogleFonts.almarai(
                            fontSize: 13.sp,
                            color: _typeColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        if (widget.file.isFromAI) ...[
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.aiModelColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              'AI',
                              style: GoogleFonts.almarai(
                                fontSize: 10.sp,
                                color: AppColors.aiModelColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
              // Actions — absorb tap to prevent parent GestureDetector from firing
              GestureDetector(
                onTap: () {}, // absorb tap
                behavior: HitTestBehavior.opaque,
                child: BlocBuilder<FolderFilesCubit, FolderFilesState>(
                  builder: (context, state) {
                    final isDeleting =
                        state is DeleteFileLoading &&
                        state.fileId == widget.file.id;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (_isDownloading)
                          SizedBox(
                            width: 34.w,
                            height: 34.h,
                            child: const Center(
                              child: SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.progressColor,
                                ),
                              ),
                            ),
                          )
                        else
                          FolderFileActionIcon(
                            icon: Icons.download_rounded,
                            tooltip: 'download'.tr(),
                            color: AppColors.progressColor,
                            onTap: () => _downloadFile(context),
                          ),
                        SizedBox(width: 6.w),
                        if (isDeleting)
                          SizedBox(
                            width: 34.w,
                            height: 34.h,
                            child: const Center(
                              child: SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.red,
                                ),
                              ),
                            ),
                          )
                        else
                          FolderFileActionIcon(
                            icon: Icons.delete_outline_rounded,
                            tooltip: 'delete'.tr(),
                            color: AppColors.red,
                            onTap: () => _confirmDelete(context),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeleteConfirmationDialog extends StatefulWidget {
  final String fileName;

  const _DeleteConfirmationDialog({required this.fileName});

  @override
  State<_DeleteConfirmationDialog> createState() =>
      _DeleteConfirmationDialogState();
}

class _DeleteConfirmationDialogState extends State<_DeleteConfirmationDialog> {
  bool _isDeleteHovered = false;
  bool _isCancelHovered = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.r)),
      child: Container(
        width: 450.w,
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF1F1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.delete_outline_rounded,
                    color: const Color(0xFFE53935),
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 15.w),
                Text(
                  'deleteFile'.tr(),
                  style: GoogleFonts.almarai(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            RichText(
              text: TextSpan(
                style: GoogleFonts.almarai(
                  fontSize: 15.sp,
                  color: Colors.grey.shade600,
                ),
                children: [
                  TextSpan(text: '${'confirmDeleteFile'.tr()} '),
                  TextSpan(
                    text: '"${widget.fileName}"',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A1A),
                    ),
                  ),
                  const TextSpan(text: ' ?'),
                ],
              ),
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context, false),
                  child: MouseRegion(
                    onEnter: (_) => setState(() => _isCancelHovered = true),
                    onExit: (_) => setState(() => _isCancelHovered = false),
                    cursor: SystemMouseCursors.click,
                    child: Text(
                      'cancel'.tr(),
                      style: GoogleFonts.almarai(
                        fontSize: 13.sp,
                        color: _isCancelHovered
                            ? const Color(0xFF1A1A1A)
                            : Colors.grey.shade500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 25.w),
                GestureDetector(
                  onTap: () => Navigator.pop(context, true),
                  child: MouseRegion(
                    onEnter: (_) => setState(() => _isDeleteHovered = true),
                    onExit: (_) => setState(() => _isDeleteHovered = false),
                    cursor: SystemMouseCursors.click,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(
                        horizontal: 25.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: _isDeleteHovered
                            ? const Color(0xFFD32F2F)
                            : const Color(0xFFEF5350),
                        borderRadius: BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFEF5350).withOpacity(0.3),
                            blurRadius: _isDeleteHovered ? 12 : 8,
                            offset: Offset(0, _isDeleteHovered ? 6 : 4),
                          ),
                        ],
                      ),
                      child: Text(
                        'delete'.tr(),
                        style: GoogleFonts.almarai(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
