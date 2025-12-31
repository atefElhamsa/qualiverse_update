import 'package:flutter/material.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = HomeBodyInherited.of(context);
    final isDrawerVisible = inherited.isDrawerVisible;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    String imagePath = Theme.of(context).brightness == Brightness.dark
        ? AppImages.iconYesRadiusDark
        : AppImages.iconYesRadiusLight;
    return CustomScaffold(
      widget: Column(
        children: [
          HomeBodyFirstPart(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            isDrawerVisible: isDrawerVisible,
          ),
          HomeBodySecondPart(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
            imagePath: imagePath,
          ),
          HomeBodyLastPart(screenWidth: screenWidth),
        ],
      ),
    );
  }
}
