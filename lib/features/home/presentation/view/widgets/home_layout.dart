import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class HomeLayout {
  static Widget buildDesktopLayout(
    bool isArabic,
    bool isTablet,
    Animation<double> fadeAnimation,
    Animation<Offset> slideAnimation,
    Animation<double> scaleAnimation,
    BuildContext context,
    String imagePath,
  ) {
    return Row(
      children: [
        if (!isArabic) ...[
          FadeTransition(
            opacity: fadeAnimation,
            child: Image.asset(imagePath, fit: BoxFit.contain),
          ),
        ],
        Expanded(
          flex: 3,
          child: HomeAnimation.buildTextContent(
            isArabic,
            false,
            slideAnimation,
            fadeAnimation,
            context,
          ),
        ),
        if (isArabic) ...[
          SizedBox(width: isTablet ? 24.w : 48.w),
          FadeTransition(
            opacity: fadeAnimation,
            child: Image.asset(
              imagePath,
              // fit: BoxFit.contain,
            ),
          ),
        ],
        SizedBox(width: isTablet ? 24.w : 48.w),
        Expanded(
          flex: 2,
          child: HomeAnimation.buildMainImage(
            scaleAnimation: scaleAnimation,
            fadeAnimation: fadeAnimation,
          ),
        ),
      ],
    );
  }

  static Widget buildMobileLayout(
    bool isArabic,
    Animation<double> fadeAnimation,
    Animation<Offset> slideAnimation,
    Animation<double> scaleAnimation,
    BuildContext context,
    String imagePath,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeTransition(opacity: fadeAnimation, child: Image.asset(imagePath)),
        SizedBox(height: 24.h),
        HomeAnimation.buildTextContent(
          isArabic,
          true,
          slideAnimation,
          fadeAnimation,
          context,
        ),
        SizedBox(height: 24.h),
        HomeAnimation.buildMainImage(
          scaleAnimation: scaleAnimation,
          fadeAnimation: fadeAnimation,
        ),
      ],
    );
  }
}
