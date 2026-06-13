import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class AiReportInfoBanner extends StatelessWidget {
  const AiReportInfoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 45.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: AppColors.red.withOpacity(0.08)),
          boxShadow: [
            BoxShadow(
              color: AppColors.red.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.info_rounded, color: AppColors.red, size: 20.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'youMustUploadThreeFilesInPdfWordTypeOnly'.tr(),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.red.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
