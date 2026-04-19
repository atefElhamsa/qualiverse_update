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
            page: AdminPage.dashboard,
            selectedPage: adminDashboardCubit.selectedSidebarItem,
            onTap: () {
              adminDashboardCubit.changePage(page: AdminPage.dashboard);
            },
          ),
          SideItemModel(
            title: 'users',
            page: AdminPage.users,
            selectedPage: adminDashboardCubit.selectedSidebarItem,
            onTap: () {
              adminDashboardCubit.changePage(page: AdminPage.users);
            },
          ),
          SideItemModel(
            title: 'cycles',
            page: AdminPage.cycles,
            selectedPage: adminDashboardCubit.selectedSidebarItem,
            onTap: () {
              adminDashboardCubit.changePage(page: AdminPage.cycles);
            },
          ),
          SideItemModel(
            title: 'standards',
            page: AdminPage.standards,
            selectedPage: adminDashboardCubit.selectedSidebarItem,
            onTap: () {
              adminDashboardCubit.changePage(page: AdminPage.standards);
            },
          ),
          SideItemModel(
            title: 'accreditation',
            page: AdminPage.accreditation,
            selectedPage: adminDashboardCubit.selectedSidebarItem,
            onTap: () {
              adminDashboardCubit.changePage(page: AdminPage.accreditation);
            },
          ),
          SideItemModel(
            title: 'auditLog',
            page: AdminPage.auditLog,
            selectedPage: adminDashboardCubit.selectedSidebarItem,
            onTap: () {
              adminDashboardCubit.changePage(page: AdminPage.auditLog);
            },
          ),
          SideItemModel(
            title: 'settings',
            page: AdminPage.settings,
            selectedPage: adminDashboardCubit.selectedSidebarItem,
            onTap: () {
              adminDashboardCubit.changePage(page: AdminPage.settings);
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
