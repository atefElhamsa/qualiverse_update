import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

// Widget that combines a custom drawer and a back icon.
class CustomDrawerAndBackWidget extends StatelessWidget {
  final AdvancedDrawerController? controller;
  final bool isDisabled;

  const CustomDrawerAndBackWidget({super.key, this.controller, this.isDisabled = false});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isDisabled,
      child: Opacity(
        opacity: isDisabled ? 0.3 : 1.0,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          // Row to display drawer, space, and back icon.
          child: Row(
            children: [
              CustomDrawer(controller: controller),
              const SizedBox(width: 50),
              CustomIconBack(controller: controller),
            ],
          ),
        ),
      ),
    );
  }
}
