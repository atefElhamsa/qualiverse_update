import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AdminDashboardTopContentWidget(title: "dashboard"),
        const SizedBox(height: 10),
        DashboardTapsWidget(),
        const SizedBox(height: 20),
        const CompletionChart(),
      ],
    );
  }
}
