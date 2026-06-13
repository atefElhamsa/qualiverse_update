import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class AiReportBottomActionBar extends StatelessWidget {
  final int uploadedCount;
  final double progress;
  final bool allUploaded;
  final bool isAr;
  final VoidCallback onSubmit;

  const AiReportBottomActionBar({
    super.key,
    required this.uploadedCount,
    required this.progress,
    required this.allUploaded,
    required this.isAr,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Progress counter
                Text(
                  '$uploadedCount / 3',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: 24.sp,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  isAr ? 'ملفات تم رفعها' : 'files uploaded',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: 20.sp,
                  ),
                ),
                const Spacer(),
                // Submit button — disabled until all 3 files uploaded
                AnimatedOpacity(
                  opacity: allUploaded ? 1.0 : 0.4,
                  duration: const Duration(milliseconds: 250),
                  child: EditApprovedButtons(onApprovedPressed: onSubmit),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            LinearProgressWidget(value: progress),
            if (!allUploaded) ...[
              SizedBox(height: 8.h),
              Text(
                isAr
                    ? 'يجب رفع الملفات الثلاثة لتفعيل الزر'
                    : 'Upload all 3 files to enable submission',
                style: TextStyle(
                  color: AppColors.red.withOpacity(0.7),
                  fontSize: 12.sp,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
