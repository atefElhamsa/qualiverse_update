import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_images.dart';
import 'custom_drawer_and_back_widget.dart';
import 'custom_text.dart';

// A stateless widget that represents the top section of a custom scaffold.
class CustomScaffoldTop extends StatelessWidget {
  final AdvancedDrawerController? controller;
  // Constructor for the CustomScaffoldTop widget.
  // It takes an optional key parameter.
  const CustomScaffoldTop({super.key, this.controller});

  @override
  // Builds the UI for the CustomScaffoldTop widget.
  Widget build(BuildContext context) {
    // Returns a Column widget to arrange its children vertically.
    return Column(
      // Aligns children to the start (left) of the cross axis.
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Displays a circular avatar.
        CircleAvatar(
          // Sets the radius of the circle.
          radius: 50.r,
          // Sets the background image of the avatar.
          backgroundImage: const AssetImage(AppImages.logo),
          // Sets the background color of the avatar to transparent.
          backgroundColor: AppColors.transparent,
        ),
        // Adds a sized box for spacing.
        const SizedBox(height: 10),
        // Displays a custom text widget.
        CustomText(
          // Sets the title text, translated using easy_localization.
          title: "accreditationQualitySystem".tr(),
          // Applies a predefined text style from the current theme.
          textStyle: Theme.of(context).textTheme.headlineLarge!,
        ),
        // Adds a sized box for spacing.
        const SizedBox(height: 10),
        // Displays a custom widget for drawer and back button functionality.
        CustomDrawerAndBackWidget(controller: controller,),
      ],
    );
  }
}
