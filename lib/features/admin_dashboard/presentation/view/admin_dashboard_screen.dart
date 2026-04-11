import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  late AdminDashboardCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = AdminDashboardCubit.get(context);
  }

  @override
  void dispose() {
    super.dispose();
    cubit.changeIndex(0);
  }

  @override
  Widget build(BuildContext context) {
    final _ = context.locale;
    return const MainWrapper(child: AdminDashboardBody());
  }
}
