import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AdminDashboardTopContentWidget(title: "dashboard"),
        const SizedBox(height: 10),
        DashboardTapsWidget(),
        const SizedBox(height: 20),
        const CompletionChart(),
      ],
    );
  }
}
