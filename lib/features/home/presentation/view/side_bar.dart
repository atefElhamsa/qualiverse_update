import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../routing/all_routes_imports.dart';

class SideBar extends StatefulWidget {
  final AdvancedDrawerController? controller;

  const SideBar({super.key, this.controller});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  void initState() {
    super.initState();
    MeCubit.get(context).getMyInfo();
  }

  @override
  Widget build(BuildContext context) {
    final _ = context.locale;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          children: [
            const CustomSidebarDrawer(),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [SideBarMenu(controller: widget.controller)],
              ),
            ),
            const LogOutWidget(),
          ],
        ),
      ),
    );
  }
}
