import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

// Widget that combines a custom drawer and a back icon.
class CustomDrawerAndBackWidget extends StatelessWidget {
  final AdvancedDrawerController? controller;
  final bool isDisabled;
  final bool showBackButton;

  const CustomDrawerAndBackWidget({
    super.key,
    this.controller,
    this.isDisabled = false,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    // In details pages (showBackButton = false), hide everything completely.
    if (!showBackButton) return const SizedBox.shrink();

    return IgnorePointer(
      ignoring: isDisabled,
      child: Opacity(
        opacity: isDisabled ? 0.3 : 1.0,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          // Row to display drawer and optionally the back icon.
          child: Row(
            children: [
              CustomDrawer(controller: controller),
              if (context.canPop()) ...[
                const SizedBox(width: 50),
                CustomIconBack(controller: controller),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
