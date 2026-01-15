import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/home/data/models/side_bar_item_model.dart';

class SideBarItem extends StatelessWidget {
  final AdvancedDrawerController? controller;

  final SideBarItemModel sideBarItemModel;

  const SideBarItem({
    super.key,
    this.controller,
    required this.sideBarItemModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        controller?.hideDrawer();
        context.push(sideBarItemModel.route!);
      },
      leading: ImageIcon(
        AssetImage(sideBarItemModel.image),
        color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
            ? AppColors.colorButtonLight
            : AppColors.sideBarItemDark,
      ),
      title: CustomText(
        title: sideBarItemModel.title.tr(),
        textStyle: TextStyle(
          color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
              ? AppColors.black
              : AppColors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
