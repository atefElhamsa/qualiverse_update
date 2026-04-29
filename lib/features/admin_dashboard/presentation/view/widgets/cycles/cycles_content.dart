import 'package:flutter/material.dart';

import '../../../../../../routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class CyclesContent extends StatelessWidget {
  const CyclesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdminDashboardTopContentWidget(title: "cycles"),
          const SizedBox(height: 10),
          const CyclesManagementScreen(),
        ],
      ),
    );
  }
}
