import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class SideBarMenu extends StatelessWidget {
  final AdvancedDrawerController? controller;

  const SideBarMenu({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isAdmin =
        context.watch<MeCubit>().state is MeSuccess &&
        (context.watch<MeCubit>().state as MeSuccess).meModel.role == 'admin';

    final visibleItems = sideBarItems
        .where((item) => !item.isAdmin || isAdmin)
        .toList();

    return Column(
      children: List.generate(visibleItems.length * 2 - 1, (index) {
        if (index.isOdd) {
          return SizedBox(height: screenHeight * 0.035);
        }
        final itemIndex = index ~/ 2;
        return SideBarItem(
          sideBarItemModel: visibleItems[itemIndex],
          controller: controller,
        );
      }),
    );
  }
}
