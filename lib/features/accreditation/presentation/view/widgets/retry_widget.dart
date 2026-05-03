import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class RetryWidget extends StatelessWidget {
  const RetryWidget({super.key, required this.title, this.onPressed});

  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: AppColors.red.withOpacity(0.8),
            size: 80.sp,
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: CustomText(
              title: title.replaceFirst('Exception: ', '').trim(),
              textAlign: TextAlign.center,
              textStyle: GoogleFonts.cairo(
                fontSize: 20.sp,
                color: AppColors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 25.h),
          if (onPressed != null)
            ElevatedButton.icon(
              onPressed: onPressed,
              icon: const Icon(Icons.refresh_rounded, color: Colors.white),
              label: Text(
                "retry".tr(),
                style: GoogleFonts.cairo(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.red,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 0,
              ),
            ),
        ],
      ),
    );
  }
}
