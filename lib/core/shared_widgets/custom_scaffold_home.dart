import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CustomScaffoldHome extends StatelessWidget {
  final AdvancedDrawerController controller;
  const CustomScaffoldHome({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 50.r,
          backgroundImage: const AssetImage(AppImages.logo),
          backgroundColor: Colors.transparent,
        ),
        SizedBox(height: 12.h),
        CustomText(
          title: "accreditationQualitySystem".tr(),
          textStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 22.sp,
                color: AppColors.mainBlack,
              ),
        ),
        SizedBox(height: 12.h),
        IconButton(
          onPressed: () {
            controller.showDrawer();
          },
          icon: Image.asset(
            AppImages.drawerImage,
            width: 35.w,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
