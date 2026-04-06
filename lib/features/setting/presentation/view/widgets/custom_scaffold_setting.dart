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
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
              ? AppColors.white
              : AppColors.mainBlack,
          borderRadius: BorderRadius.circular(23.r),
        ),
        child: widget,
      ),
    );
  }
}
