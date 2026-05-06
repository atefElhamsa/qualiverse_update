import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AdminDashboardContent extends StatelessWidget {
  const AdminDashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminDashboardCubit, AdminDashboardState>(
      builder: (context, state) {
        final cubit = AdminDashboardCubit.get(context);

        final Widget content;
        switch (cubit.currentPage) {
          case AdminPage.dashboard:
            content = const DashboardContent();
            break;
          case AdminPage.users:
            content = const UsersContent();
            break;
          case AdminPage.cycles:
            content = const CyclesContent();
            break;
          case AdminPage.cycleDetails:
            content = const CyclesDetailsScreen();
            break;
        }

        if (cubit.currentPage == AdminPage.dashboard) {
          return content;
        }

        return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 100.h),
            child: content,
          ),
        );
      },
    );
  }
}
