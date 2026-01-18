import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';

import '../../../../routing/all_routes_imports.dart';

class SideBar extends StatelessWidget {
  final AdvancedDrawerController? controller;

  const SideBar({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    final _ = context.locale;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 15),
        child: Column(
          children: [
            const CustomSidebarDrawer(),
            Expanded(
              child: ListView(children: [SideBarMenu(controller: controller)]),
            ),
            const LogOutWidget(),
          ],
        ),
      ),
    );
  }
}
