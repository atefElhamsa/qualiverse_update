import 'package:flutter/material.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class WhiteContainerWidget extends StatelessWidget {
  const WhiteContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth / 2.06,
      height: screenHeight,
      decoration: BoxDecoration(color: AppColors.whiteGrey.withOpacity(0.90)),
    );
  }
}
