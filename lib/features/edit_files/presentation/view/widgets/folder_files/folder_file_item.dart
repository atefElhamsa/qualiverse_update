import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

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

  Future<void> _downloadFile(BuildContext context) async {
    setState(() => _isDownloading = true);
    final error = await FileDownloadHelper.downloadAndOpen(
      filePath: widget.file.filePath,
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
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: Row(
          children: [
            Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: AppColors.red.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.delete_outline_rounded,
                color: AppColors.red,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              'deleteFile'.tr(),
              style: GoogleFonts.almarai(
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        content: RichText(
          text: TextSpan(
            style: GoogleFonts.almarai(
              fontSize: 15.sp,
              color: AppColors.greyLight,
            ),
            children: [
              TextSpan(text: 'confirmDeleteFile'.tr()),
              TextSpan(
                text: ' "${widget.file.fileName}" ',
                style: GoogleFonts.almarai(
                  fontWeight: FontWeight.w700,
                  color: AppColors.mainBlack,
                  fontSize: 15.sp,
                ),
              ),
              const TextSpan(text: '؟'),
            ],
          ),
        ),
        actions: [
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: Size(60.w, 36.h),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
            ),
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(
              'cancel'.tr(),
              style: GoogleFonts.almarai(
                color: AppColors.greyLight,
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              foregroundColor: Colors.white,
              minimumSize: Size(70.w, 36.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(
              'delete'.tr(),
              style: GoogleFonts.almarai(
                fontWeight: FontWeight.w700,
                fontSize: 15.sp,
              ),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await cubit.deleteFile(folderId: widget.folderId, fileId: widget.file.id);
    }
  }

  Color get _typeColor {
    final t = widget.file.fileType.toLowerCase();
    if (t.contains('pdf')) return const Color(0xFFE53935);
    if (t.contains('doc') || t.contains('word')) return const Color(0xFF1565C0);
    if (t.contains('png') || t.contains('jpg') || t.contains('image')) {
      return const Color(0xFF2E7D32);
    }
    return const Color(0xFF6D4C41);
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
    if (t.contains('.xls') || t.contains('.xlsx')) {
      return Icons.file_copy_rounded;
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
        onTap: () {
          context.read<IndicatorsCubit>().openIndicatorFile(
            widget.file.filePath,
          );
        },
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
