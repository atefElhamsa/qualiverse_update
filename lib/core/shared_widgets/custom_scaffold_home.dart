import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'package:qualiverse/core/shared_widgets/custom_drawer.dart';

import '../utils/app_colors.dart';
import '../utils/app_images.dart';
// import 'custom_drawer_and_back_widget.dart';
import 'custom_text.dart';

// A stateless widget that represents the top section of a custom scaffold.
class CustomScaffoldHome extends StatelessWidget {
  final AdvancedDrawerController controller;
  const CustomScaffoldHome({super.key, required this.controller});

  // Constructor for the CustomScaffoldTop widget.
  // It takes an optional key parameter.
  @override
  // Builds the UI for the CustomScaffoldTop widget.
  Widget build(BuildContext context) {
    // Returns a Column widget to arrange its children vertically.
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
