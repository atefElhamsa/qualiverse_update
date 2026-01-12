import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import '../utils/app_images.dart';

// A custom drawer widget.
class CustomDrawer extends StatelessWidget {
  final AdvancedDrawerController? controller;
  // Constructor for the CustomDrawer widget.
  const CustomDrawer({super.key, this.controller});

  // Builds the widget tree for the custom drawer.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller?.showDrawer();
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Image.asset(AppImages.drawerImage, fit: BoxFit.cover),
      ),
    );
  }
}
