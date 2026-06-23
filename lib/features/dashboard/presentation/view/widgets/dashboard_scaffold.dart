import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/all_core_imports/all_core_imports.dart';

class DashboardScaffold extends StatelessWidget {
  const DashboardScaffold({super.key, required this.widget, this.onRefresh});
  final Widget widget;
  final Future<void> Function()? onRefresh;

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
          ? BoxDecoration(
              gradient: LinearGradient(
                // Define gradient for light theme.
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  AppColors.scaffoldLight1,
                  AppColors.colorButtonLight,
                  Colors.purple.shade300,
                ],
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
            ? EdgeInsets.only(top: 15.h, bottom: 15.h, left: 15.w, right: 15.w)
            : null,
        decoration: Theme.of(context).scaffoldBackgroundColor == AppColors.white
            // Apply background color and border radius for light theme.
            ? BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(25.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              )
            : null,
        // Make the content scrollable.
        child: RefreshIndicator(
          onRefresh: () async {
            if (onRefresh != null) {
              await onRefresh!();
            }
          },
          child: widget,
        ),
      ),
    );
  }
}
