import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

// Define a custom scaffold widget.
class CustomScaffold extends StatelessWidget {
  // Constructor for CustomScaffold.
  const CustomScaffold({super.key, required this.widget});

  // The widget to be displayed within the scaffold.
  final Widget widget;

  // Build method to create the widget's UI.
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
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
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
        padding: EdgeInsets.only(
          left: locale == const Locale('ar') ? 0 : 27.w,
          right: locale == const Locale('ar') ? 0 : 27.w,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
              ? AppColors.white
              : AppColors.mainBlack,
          borderRadius: BorderRadius.circular(23.r),
        ),
        // Make the content scrollable.
        child: SingleChildScrollView(child: widget),
      ),
    );
  }
}
