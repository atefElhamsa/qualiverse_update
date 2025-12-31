import 'package:flutter/material.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key});

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  int? selectedYear;
  final List<int> years = [2022, 2023, 2024, 2025];

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // FirstTermTopAndTitle(title: "dashboard"),
          ListData(),
        ],
      ),
    );
  }
}
