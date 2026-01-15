import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import 'custom_text.dart';

class CustomSidebarDrawer extends StatelessWidget {
  const CustomSidebarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 50.r,
          backgroundImage: const AssetImage(AppImages.logo),
          backgroundColor: AppColors.transparent,
        ),
        const SizedBox(height: 10),
        CustomText(
          title: "accreditationQualitySystem".tr(),
          textStyle: Theme.of(
            context,
          ).textTheme.headlineLarge!.copyWith(fontSize: 16.sp),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
