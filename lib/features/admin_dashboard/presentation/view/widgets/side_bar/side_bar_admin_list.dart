import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../routing/all_routes_imports.dart';

class SideBarAdminList extends StatelessWidget {
  const SideBarAdminList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminDashboardCubit, AdminDashboardState>(
      builder: (context, state) {
        final adminDashboardCubit = AdminDashboardCubit.get(context);
        final List<SideItemModel> sideAdminItems = [
          SideItemModel(
            title: 'dashboard',
            index: 0,
            selectedIndex: adminDashboardCubit.selectedIndex,
            onTap: () {
              adminDashboardCubit.changeIndex(0);
            },
          ),
          SideItemModel(
            title: 'users',
            index: 1,
            selectedIndex: adminDashboardCubit.selectedIndex,
            onTap: () {
              adminDashboardCubit.changeIndex(1);
            },
          ),
          SideItemModel(
            title: 'cycles',
            index: 2,
            selectedIndex: adminDashboardCubit.selectedIndex,
            onTap: () {
              adminDashboardCubit.changeIndex(2);
            },
          ),
          SideItemModel(
            title: 'standards',
            index: 3,
            selectedIndex: adminDashboardCubit.selectedIndex,
            onTap: () {
              adminDashboardCubit.changeIndex(3);
            },
          ),
          SideItemModel(
            title: 'accreditation',
            index: 4,
            selectedIndex: adminDashboardCubit.selectedIndex,
            onTap: () {
              adminDashboardCubit.changeIndex(4);
            },
          ),
          SideItemModel(
            title: 'auditLog',
            index: 5,
            selectedIndex: adminDashboardCubit.selectedIndex,
            onTap: () {
              adminDashboardCubit.changeIndex(5);
            },
          ),
          SideItemModel(
            title: 'settings',
            index: 6,
            selectedIndex: adminDashboardCubit.selectedIndex,
            onTap: () {
              adminDashboardCubit.changeIndex(6);
            },
          ),
        ];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10.h,
          children: List.generate(
            sideAdminItems.length,
            (index) => SideItem(sideItemModel: sideAdminItems[index]),
          ),
        );
      },
    );
  }
}
