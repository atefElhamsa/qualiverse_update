import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:go_router/go_router.dart';

import '../utils/app_colors.dart';
import '../utils/app_images.dart';

// Define a stateless widget for a custom back icon.
class CustomIconBack extends StatelessWidget {
  final AdvancedDrawerController? controller;
  // Constructor for the CustomIconBack widget.
  const CustomIconBack({super.key , this.controller});

  @override
  Widget build(BuildContext context) {
    // Use GestureDetector to handle tap events.
    return GestureDetector(
      onTap: () {
        // Navigate back to the previous screen using GoRouter.
        context.pop();
        
      },
      // Display an image that changes based on the theme (light/dark).
      child: Image.asset(
        Theme.of(context).scaffoldBackgroundColor == AppColors.white
            ? AppImages.iconBackLight
            : AppImages.iconBackDark,
        fit: BoxFit.cover,
      ),
    );
  }
}
