import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class HomeLayout {
  static Widget buildDesktopLayout(
    bool isArabic,
    bool isTablet,
    BuildContext context,
    String imagePath,
  ) {
    return Row(
      children: [
        Image.asset(imagePath, fit: BoxFit.contain).animate().fadeIn(),
        Expanded(
          flex: 3,
          child: HomeAnimation.buildTextContent(
            isArabic,
            false,
            context,
          ),
        ),
        SizedBox(width: isTablet ? 24.w : 48.w),
        Expanded(
          flex: 2,
          child: HomeAnimation.buildMainImage(),
        ),
      ],
    );
  }

  static Widget buildMobileLayout(
    bool isArabic,
    BuildContext context,
    String imagePath,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath).animate().fadeIn(),
        SizedBox(height: 24.h),
        HomeAnimation.buildTextContent(
          isArabic,
          true,
          context,
        ),
        SizedBox(height: 24.h),
        HomeAnimation.buildMainImage(),
      ],
    );
  }
}
