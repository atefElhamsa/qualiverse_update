import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class CustomScaffoldSetting extends StatelessWidget {
  const CustomScaffoldSetting({super.key, required this.widget});
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      height: screenHeight,
      decoration: Theme.of(context).scaffoldBackgroundColor == AppColors.white
          ? const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [AppColors.scaffoldLight1, AppColors.colorButtonLight],
              ),
            )
          : const BoxDecoration(color: AppColors.mainBlack),
      child: Container(
        width: screenWidth,
        height: screenHeight,
        margin: Theme.of(context).scaffoldBackgroundColor == AppColors.white
            // Apply margin only for light theme.
            ? EdgeInsets.only(top: 25.h, bottom: 25.h, left: 25.w, right: 25.w)
            : null,
        decoration: Theme.of(context).scaffoldBackgroundColor == AppColors.white
            // Apply background color and border radius for light theme.
            ? BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(23.r),
              )
            : null,
        child: SingleChildScrollView(child: widget),
      ),
    );
  }
}
