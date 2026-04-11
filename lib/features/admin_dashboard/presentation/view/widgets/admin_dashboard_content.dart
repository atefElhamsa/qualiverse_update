import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AdminDashboardContent extends StatelessWidget {
  const AdminDashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminDashboardCubit, AdminDashboardState>(
      builder: (context, selectedIndex) {
        final adminDashboardCubit = AdminDashboardCubit.get(context);
        return [
          const DashboardContent(),
          const UsersContent(),
          const CyclesContent(),
          const StandardsContent(),
          const AccreditationContent(),
          const AuditLogContent(),
          const SettingsContent(),
        ][adminDashboardCubit.selectedIndex];
      },
    );
  }
}
