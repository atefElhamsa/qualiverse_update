import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class AiReportJobStatusLoadingWidget extends StatelessWidget {
  final bool isAr;

  const AiReportJobStatusLoadingWidget({super.key, required this.isAr});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.h),
      child: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: const CircularProgressIndicator(
                color: AppColors.colorButtonLight,
                strokeWidth: 3,
              ),
            ),
            SizedBox(height: 25.h),
            Text(
              isAr
                  ? "جاري إنشاء الملفات بذكاء اصطناعي..."
                  : "Generating files with AI...",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.colorButtonLight,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              isAr
                  ? "يرجى الانتظار، قد تستغرق هذه العملية بضع ثوانٍ"
                  : "Please wait, this might take a few seconds",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
