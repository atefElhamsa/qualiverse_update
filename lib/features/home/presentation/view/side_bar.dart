import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class SideBar extends StatelessWidget {
  final AdvancedDrawerController? controller;

  const SideBar({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    final _ = context.locale;
    return SafeArea(
      child: ListView(
        padding: const EdgeInsetsDirectional.only(start: 15),
        children: [
          const CustomSidebarDrawer(),
          SideBarMenu(controller: controller),
        ],
      ),
    );
  }
}
