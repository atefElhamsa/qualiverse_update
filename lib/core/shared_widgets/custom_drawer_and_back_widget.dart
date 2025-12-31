import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import 'custom_drawer.dart';
import 'custom_icon_back.dart';

// Widget that combines a custom drawer and a back icon.
class CustomDrawerAndBackWidget extends StatelessWidget {
  final AdvancedDrawerController? controller;

  const CustomDrawerAndBackWidget({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      // Row to display drawer, space, and back icon.
      child: Row(
        children: [
          CustomDrawer(controller: controller),
          const SizedBox(width: 50),
          CustomIconBack(controller: controller),
        ],
      ),
    );
  }
}
