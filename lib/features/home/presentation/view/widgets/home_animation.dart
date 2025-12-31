import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class HomeAnimation {
  static Widget buildMainImage({
    required Animation<double> scaleAnimation,
    required Animation<double> fadeAnimation,
  }) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(63.r),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mainBlack.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Image.asset(
                  AppImages.homeBodySecondPartImage,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget buildTextContent(
    bool isArabic,
    bool isMobile,
    Animation<Offset> slideAnimation,
    Animation<double> fadeAnimation,
    BuildContext context,
  ) {
    return SlideTransition(
      position: slideAnimation,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: Column(
          crossAxisAlignment: isMobile
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              title: "accreditationQualitySystem".tr(),
              textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: isMobile ? 25.sp : 40.sp,
              ),
              textAlign: isMobile ? TextAlign.center : TextAlign.start,
            ),
            SizedBox(height: 16.h),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: isMobile
                    ? double.infinity
                    : (isArabic ? 400.w : 500.w),
              ),
              child: CustomText(
                title:
                    "AnAcademicSystemThatAimsToEnsureQualityInAcademicProcessesInLineWithInternationalStandards"
                        .tr(),
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: isMobile ? 14.sp : 24.sp,
                  height: 2,
                ),
                textAlign: isMobile ? TextAlign.center : TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
