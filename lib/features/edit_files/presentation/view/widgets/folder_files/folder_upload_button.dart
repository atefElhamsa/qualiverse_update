import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class FolderUploadButton extends StatefulWidget {
  final VoidCallback onUpload;
  final bool isLoading;

  const FolderUploadButton({
    super.key,
    required this.onUpload,
    this.isLoading = false,
  });

  @override
  State<FolderUploadButton> createState() => _FolderUploadButtonState();
}

class _FolderUploadButtonState extends State<FolderUploadButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.isLoading
          ? SystemMouseCursors.basic
          : SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.isLoading ? null : widget.onUpload,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 46.h,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            color: widget.isLoading
                ? AppColors.progressColor.withOpacity(0.6)
                : _hovered
                    ? AppColors.progressColor.withOpacity(0.85)
                    : AppColors.progressColor,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: _hovered && !widget.isLoading
                ? [
                    BoxShadow(
                      color: AppColors.progressColor.withOpacity(0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.isLoading)
                SizedBox(
                  width: 18.w,
                  height: 18.h,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              else
                Icon(Icons.upload_file, color: Colors.white, size: 18.sp),
              SizedBox(width: 8.w),
              Text(
                widget.isLoading ? 'uploading'.tr() : 'uploadFile'.tr(),
                style: GoogleFonts.cairo(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
