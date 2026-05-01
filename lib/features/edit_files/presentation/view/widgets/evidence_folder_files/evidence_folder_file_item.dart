import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/helpers/file_download_helper.dart';
import 'package:qualiverse/core/utils/end_points.dart';
import 'package:qualiverse/features/edit_files/data/models/evidence_file_model.dart';
import 'package:qualiverse/features/edit_files/presentation/controller/evidence_folder_files_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class EvidenceFolderFileItem extends StatefulWidget {
  final EvidenceFileModel file;
  final bool isArabic;
  final int folderId;
  final bool isHighlighted;

  const EvidenceFolderFileItem({
    super.key,
    required this.file,
    required this.isArabic,
    required this.folderId,
    this.isHighlighted = false,
  });

  @override
  State<EvidenceFolderFileItem> createState() => _EvidenceFolderFileItemState();
}

class _EvidenceFolderFileItemState extends State<EvidenceFolderFileItem> {
  bool _isDownloading = false;
  bool _isItemHovered = false;

  Future<void> _openFile() async {
    final String fullUrl =
        "${EndPoints.baseUrlToOpenFile}/${widget.file.filePath}";
    final Uri url = Uri.parse(fullUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _downloadFile() async {
    setState(() => _isDownloading = true);
    final error = await FileDownloadHelper.downloadAndOpen(
      filePath: widget.file.filePath,
      fileName: widget.file.fileName,
    );
    if (mounted) {
      setState(() => _isDownloading = false);
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _confirmDelete() async {
    final cubit = EvidenceFolderFilesCubit.get(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => _DeleteConfirmationDialog(
        fileName: widget.file.fileName,
      ),
    );

    if (confirmed == true) {
      await cubit.deleteFile(
        fileId: widget.file.id,
        folderId: widget.folderId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final fileTypeData = _getFileTypeData(widget.file.fileType);

    return MouseRegion(
      onEnter: (_) => setState(() => _isItemHovered = true),
      onExit: (_) => setState(() => _isItemHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _openFile,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: widget.isHighlighted
                ? const Color(0xFFE8F1FF)
                : (_isItemHovered ? const Color(0xFFF0F7FF) : Colors.white),
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(
              color: _isItemHovered
                  ? const Color(0xFF4285F4).withOpacity(0.4)
                  : Colors.black.withOpacity(0.05),
            ),
            boxShadow: [
              if (_isItemHovered)
                BoxShadow(
                  color: const Color(0xFF4285F4).withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: _isItemHovered ? fileTypeData.mainColor.withOpacity(0.1) : fileTypeData.bgColor,
                  borderRadius: BorderRadius.circular(10.r),
                  border: _isItemHovered ? Border.all(color: fileTypeData.mainColor.withOpacity(0.2)) : null,
                ),
                child: Icon(
                  fileTypeData.icon,
                  color: fileTypeData.mainColor,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.file.fileName,
                      style: GoogleFonts.cairo(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: _isItemHovered ? const Color(0xFF0F569E) : const Color(0xFF333333),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.file.fileSize,
                          style: GoogleFonts.cairo(
                            fontSize: 11.sp,
                            color: Colors.grey.shade500,
                          ),
                        ),
                        Text(
                          ' • ',
                          style: TextStyle(color: Colors.grey.shade300, fontSize: 11.sp),
                        ),
                        Text(
                          widget.file.fileType.toUpperCase(),
                          style: GoogleFonts.cairo(
                            fontSize: 11.sp,
                            color: fileTypeData.mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  _isDownloading
                      ? SizedBox(
                          width: 20.w,
                          height: 20.h,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                                fileTypeData.mainColor),
                          ),
                        )
                      : _ActionHoverButton(
                          icon: Icons.download_rounded,
                          color: const Color(0xFF42A5F5),
                          hoverColor: const Color(0xFFE8F1FF),
                          tooltip: 'download'.tr(),
                          onPressed: _downloadFile,
                        ),
                  SizedBox(width: 8.w),
                  _ActionHoverButton(
                    icon: Icons.delete_outline_rounded,
                    color: const Color(0xFFEF5350),
                    hoverColor: const Color(0xFFFFF1F1),
                    tooltip: 'delete'.tr(),
                    onPressed: _confirmDelete,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _FileTypeData _getFileTypeData(String type) {
    final t = type.toLowerCase().replaceAll('.', '');
    if (t == 'pdf') {
      return _FileTypeData(
        icon: Icons.picture_as_pdf_rounded,
        mainColor: const Color(0xFFE53935),
        bgColor: const Color(0xFFFFF1F1),
      );
    } else if (['jpg', 'jpeg', 'png', 'gif', 'svg'].contains(t)) {
      return _FileTypeData(
        icon: Icons.image_rounded,
        mainColor: const Color(0xFF8E24AA),
        bgColor: const Color(0xFFF3E5F5),
      );
    } else if (['doc', 'docx', 'txt', 'rtf'].contains(t)) {
      return _FileTypeData(
        icon: Icons.description_rounded,
        mainColor: const Color(0xFF1E88E5),
        bgColor: const Color(0xFFE3F2FD),
      );
    } else if (['xls', 'xlsx', 'csv'].contains(t)) {
      return _FileTypeData(
        icon: Icons.table_chart_rounded,
        mainColor: const Color(0xFF43A047),
        bgColor: const Color(0xFFE8F5E9),
      );
    } else {
      return _FileTypeData(
        icon: Icons.insert_drive_file_rounded,
        mainColor: Colors.blueGrey,
        bgColor: Colors.blueGrey.withOpacity(0.1),
      );
    }
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
                  child: Icon(Icons.delete_outline_rounded,
                      color: const Color(0xFFE53935), size: 24.sp),
                ),
                SizedBox(width: 15.w),
                Text(
                  'deleteFile'.tr(),
                  style: GoogleFonts.cairo(
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
                style: GoogleFonts.cairo(
                  fontSize: 15.sp,
                  color: Colors.grey.shade600,
                ),
                children: [
                  TextSpan(text: 'deleteFileMessage'.tr() + ' '),
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
                      style: GoogleFonts.cairo(
                        fontSize: 16.sp,
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
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
                        style: GoogleFonts.cairo(
                          color: Colors.white,
                          fontSize: 16.sp,
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

class _FileTypeData {
  final IconData icon;
  final Color mainColor;
  final Color bgColor;

  _FileTypeData({
    required this.icon,
    required this.mainColor,
    required this.bgColor,
  });
}

class _ActionHoverButton extends StatefulWidget {
  final IconData icon;
  final Color color;
  final Color hoverColor;
  final String tooltip;
  final VoidCallback onPressed;

  const _ActionHoverButton({
    required this.icon,
    required this.color,
    required this.hoverColor,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  State<_ActionHoverButton> createState() => _ActionHoverButtonState();
}

class _ActionHoverButtonState extends State<_ActionHoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: _isHovered ? widget.hoverColor : Colors.transparent,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              widget.icon,
              color: widget.color,
              size: 20.sp,
            ),
          ),
        ),
      ),
    );
  }
}
