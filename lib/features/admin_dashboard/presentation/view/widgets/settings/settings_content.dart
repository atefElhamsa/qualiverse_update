import 'package:flutter/material.dart';

import '../../../../../../routing/all_routes_imports.dart';

class SettingsContent extends StatelessWidget {
  const SettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [AdminDashboardTopContentWidget(title: "settings")],
    );
  }
}
