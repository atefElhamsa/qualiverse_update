import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class SideBarMenu extends StatelessWidget {
  final AdvancedDrawerController? controller;

  const SideBarMenu({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: List.generate(sideBarItems.length * 2 - 1, (index) {
        if (index.isOdd) {
          return SizedBox(height: screenHeight * 0.04);
        }
        final itemIndex = index ~/ 2;
        return SideBarItem(
          sideBarItemModel: sideBarItems[itemIndex],
          controller: controller,
        );
      }),
    );
  }
}
