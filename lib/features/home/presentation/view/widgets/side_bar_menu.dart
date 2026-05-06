import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class SideBarMenu extends StatelessWidget {
  final AdvancedDrawerController? controller;

  const SideBarMenu({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    final _ = context.locale;
    final isAdmin =
        context.watch<MeCubit>().state is MeSuccess &&
        (context.watch<MeCubit>().state as MeSuccess).meModel.role == 'admin';

    final visibleItems = sideBarItems
        .where((item) => !item.isAdmin || isAdmin)
        .toList();

    return Column(
      children: List.generate(visibleItems.length * 2 - 1, (index) {
        if (index.isOdd) {
          return SizedBox(height: 8.h);
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
