import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardScaffold(
      widget: ListView(
        children: [const DashboardTopAndTitle(), const DashboardTabs()],
      ),
    );
  }
}
