import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class HomeBodySecondPart extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final String imagePath;

  const HomeBodySecondPart({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    return LayoutBuilder(
      builder: (context, constraints) {
        return isMobile
            ? HomeLayout.buildMobileLayout(
                isArabic,
                context,
                imagePath,
              )
            : HomeLayout.buildDesktopLayout(
                isArabic,
                isTablet,
                context,
                imagePath,
              );
      },
    );
  }
}
