import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/all_core_imports/all_core_imports.dart';

class DashboardScaffold extends StatelessWidget {
  const DashboardScaffold({super.key, required this.widget});
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions.
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // Get current locale.
    Locale locale = WidgetsBinding.instance.platformDispatcher.locale;
    return Container(
      width: screenWidth,
      height: screenHeight,
      decoration: Theme.of(context).scaffoldBackgroundColor == AppColors.white
          ? const BoxDecoration(
              gradient: LinearGradient(
                // Define gradient for light theme.
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [AppColors.scaffoldLight1, AppColors.colorButtonLight],
              ),
            )
          : const BoxDecoration(color: AppColors.mainBlack),
      child: Container(
        width: screenWidth,
        height: screenHeight,
        padding: EdgeInsets.only(
          // Adjust padding based on locale (for LTR/RTL support).
          left: locale == const Locale('ar') ? 0 : 27.w,
          right: locale == const Locale('ar') ? 0 : 27.w,
        ),
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
        // Make the content scrollable.
        child: widget,
      ),
    );
  }
}
