import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class HomeAnimation {
  static Widget buildMainImage() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
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
    ).animate().fadeIn(duration: 800.ms).scale(
          begin: const Offset(0.8, 0.8),
          end: const Offset(1, 1),
          curve: Curves.easeOutBack,
          duration: 800.ms,
        );
  }

  static Widget buildTextContent(
    bool isArabic,
    bool isMobile,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment:
          isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          title: "accreditationQualitySystem".tr(),
          textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: isMobile ? 26.sp : 42.sp,
                fontWeight: FontWeight.w900,
                height: 1.2,
                fontFamily: 'Tajawal',
              ),
          textAlign: isMobile ? TextAlign.center : TextAlign.start,
        ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.1, end: 0),
        SizedBox(height: 16.h),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isMobile ? double.infinity : (isArabic ? 400.w : 500.w),
          ),
          child: CustomText(
            title:
                "AnAcademicSystemThatAimsToEnsureQualityInAcademicProcessesInLineWithInternationalStandards"
                    .tr(),
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: isMobile ? 15.sp : 22.sp,
                  height: 1.6,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Tajawal',
                ),
            textAlign: isMobile ? TextAlign.center : TextAlign.start,
          ),
        ).animate().fadeIn(delay: 200.ms, duration: 600.ms).slideX(begin: -0.1, end: 0),
      ],
    );
  }
}
