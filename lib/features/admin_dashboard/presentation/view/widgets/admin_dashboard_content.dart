import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AdminDashboardContent extends StatelessWidget {
  const AdminDashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminDashboardCubit, AdminDashboardState>(
      builder: (context, state) {
        final cubit = AdminDashboardCubit.get(context);

        switch (cubit.currentPage) {
          case AdminPage.dashboard:
            return const DashboardContent();

          case AdminPage.users:
            return const UsersContent();

          case AdminPage.cycles:
            return const CyclesContent();

          case AdminPage.standards:
            return const StandardsContent();

          case AdminPage.accreditation:
            return const AccreditationContent();

          case AdminPage.auditLog:
            return const AuditLogContent();

          case AdminPage.settings:
            return const SettingsContent();

          case AdminPage.cycleDetails:
            return const CyclesDetailsScreen();
        }
      },
    );
  }
}
