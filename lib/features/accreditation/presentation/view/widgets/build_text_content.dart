import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class BuildTextContent extends StatelessWidget {
  const BuildTextContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 40.r,
          backgroundImage: AssetImage(
            Theme.of(context).scaffoldBackgroundColor == AppColors.white
                ? AppImages.iconYesRadiusLight
                : AppImages.iconYesRadiusDark,
          ),
          backgroundColor: AppColors.transparent,
        ),
        SizedBox(width: 15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: "accreditationQualitySystem".tr(),
                textStyle: Theme.of(context).textTheme.titleLarge!,
              ),
              SizedBox(height: 8.h),
              CustomText(
                title: "academicSystem".tr(),
                textStyle: Theme.of(context).textTheme.bodyMedium!,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
