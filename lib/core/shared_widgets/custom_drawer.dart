import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

// A custom drawer widget.
class CustomDrawer extends StatelessWidget {
  final AdvancedDrawerController? controller;

  // Constructor for the CustomDrawer widget.
  const CustomDrawer({super.key, this.controller});

  // Builds the widget tree for the custom drawer.
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          controller?.showDrawer();
        },
        child: Image.asset(AppImages.drawerImage, fit: BoxFit.cover),
      ),
    );
  }
}
