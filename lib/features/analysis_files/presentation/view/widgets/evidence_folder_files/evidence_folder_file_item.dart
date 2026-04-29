import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/core/helpers/file_download_helper.dart';
import 'package:qualiverse/features/analysis_files/data/model/evidence_file_model.dart';
import 'package:qualiverse/features/analysis_files/presentation/controller/evidence_folder_files_cubit.dart';
import 'package:qualiverse/features/indicators/presentation/controller/indicators_cubit.dart';
import 'package:qualiverse/features/login/presentation/view/widgets/error_widget.dart';

class FolderFileActionIcon extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final Color color;
  final VoidCallback onTap;

  const FolderFileActionIcon({
    super.key,
    required this.icon,
    required this.tooltip,
    required this.color,
    required this.onTap,
  });

  @override
  State<FolderFileActionIcon> createState() => _FolderFileActionIconState();
}

class _FolderFileActionIconState extends State<FolderFileActionIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 34.w,
            height: 34.h,
            decoration: BoxDecoration(
              color:
                  _hovered ? widget.color.withOpacity(0.15) : Colors.transparent,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(widget.icon, color: widget.color, size: 18.sp),
          ),
        ),
      ),
    );
  }
}

class EvidenceFolderFileItem extends StatefulWidget {
  final EvidenceFileModel file;
  final bool isArabic;
  final int folderId;

  const EvidenceFolderFileItem({
    super.key,
    required this.file,
    required this.isArabic,
    required this.folderId,
  });

  @override
  State<EvidenceFolderFileItem> createState() => _EvidenceFolderFileItemState();
}

class _EvidenceFolderFileItemState extends State<EvidenceFolderFileItem> {
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
    final cubit = EvidenceFolderFilesCubit.get(context);
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
              'deleteFile'. tr(),
              style: GoogleFonts.cairo(
                fontSize: 17.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        content: Text(
          'confirmDeleteFile'.tr(),
          style: GoogleFonts.cairo(fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              'cancel'.tr(),
              style: GoogleFonts.cairo(
                fontSize: 13.sp,
                color: AppColors.greyLight,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.red,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            child: Text(
              'delete'.tr(),
              style: GoogleFonts.cairo(
                fontSize: 13.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 8.w),
        ],
      ),
    );

    if (confirmed == true) {
      await cubit.deleteFile(
        fileId: widget.file.id,
        folderId: widget.folderId,
      );
    }
  }

  IconData _getFileIcon(String type) {
    final t = type.toLowerCase();
    if (t.contains('pdf')) return Icons.picture_as_pdf_rounded;
    if (t.contains('doc')) return Icons.description_rounded;
    if (t.contains('xls')) return Icons.table_chart_rounded;
    if (t.contains('jpg') || t.contains('png')) return Icons.image_rounded;
    return Icons.insert_drive_file_rounded;
  }

  Widget _buildInfoTag({required IconData icon, required String label}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14.sp, color: AppColors.greyLight),
        SizedBox(width: 4.w),
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 11.sp,
            color: AppColors.greyLight,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () {
          context.read<IndicatorsCubit>().openIndicatorFile(widget.file.filePath);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: _hovered
                ? AppColors.progressColor.withOpacity(0.05)
                : (isDark ? AppColors.mainBlack : Colors.white),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: _hovered
                  ? AppColors.progressColor.withOpacity(0.5)
                  : AppColors.greyLight.withOpacity(0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // File Icon
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: AppColors.progressColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  _getFileIcon(widget.file.fileType),
                  color: AppColors.progressColor,
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 14.w),
              // File Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.file.fileName,
                      style: GoogleFonts.cairo(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.file.fileSize,
                          style: GoogleFonts.cairo(
                            fontSize: 12.sp,
                            color: AppColors.greyLight,
                          ),
                        ),
                        Text(
                          ' • ',
                          style: TextStyle(color: AppColors.greyLight),
                        ),
                        Text(
                          widget.file.fileType.toUpperCase(),
                          style: GoogleFonts.cairo(
                            fontSize: 12.sp,
                            color: AppColors.progressColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Wrap(
                      spacing: 12.w,
                      runSpacing: 4.h,
                      children: [
                        if (widget.file.courseName.isNotEmpty)
                          _buildInfoTag(
                            icon: Icons.book_outlined,
                            label: widget.file.courseName,
                          ),
                        if (widget.file.departmentName != null &&
                            widget.file.departmentName!.isNotEmpty)
                          _buildInfoTag(
                            icon: Icons.account_balance_outlined,
                            label: widget.file.departmentName!,
                          ),
                        if (widget.file.yearNumber != 0)
                          _buildInfoTag(
                            icon: Icons.calendar_today_outlined,
                            label: widget.file.yearNumber.toString(),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              // Action Buttons
              GestureDetector(
                onTap: () {}, // Absorb
                behavior: HitTestBehavior.opaque,
                child: Row(
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
                      ),
                    if (!_isDownloading)
                      FolderFileActionIcon(
                        icon: Icons.download_rounded,
                        tooltip: widget.isArabic ? 'تحميل' : 'Download',
                        color: AppColors.progressColor,
                        onTap: () => _downloadFile(context),
                      ),
                    SizedBox(width: 8.w),
                    FolderFileActionIcon(
                      icon: Icons.delete_outline_rounded,
                      tooltip: widget.isArabic ? 'حذف' : 'Delete',
                      color: AppColors.red,
                      onTap: () => _confirmDelete(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
