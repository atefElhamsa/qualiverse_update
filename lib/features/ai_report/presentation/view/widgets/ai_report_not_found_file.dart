import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class AiReportNotFoundFile extends StatelessWidget {
  const AiReportNotFoundFile({super.key, required this.titleFile});

  final String titleFile;

  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Premium icon circle
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF6FF), // Light blue background
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3B82F6).withOpacity(0.15),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: Image.asset(
                AppImages.iconUpload,
                height: 28.h,
                color: const Color(0xFF2563EB), // Primary blue
              ),
            ),
          ),
          SizedBox(height: 16.h),
          // Title (e.g. Survey PDF)
          Text(
            titleFile.tr(),
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontSize: 18.sp,
              color: const Color(0xFF1E293B), // Slate 800
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          // "Choose a file"
          Text(
            "chooseFile".tr(),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 15.sp,
              color: const Color(0xFF3B82F6), // Blue 500
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 4.h),
          // Hint text
          Text(
            "uploadHint".tr(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              fontSize: 13.sp,
              color: const Color(0xFF94A3B8), // Slate 400
            ),
          ),
        ],
      ),
    );
  }
}
