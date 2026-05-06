import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../routing/all_routes_imports.dart';

class CyclesContent extends StatelessWidget {
  const CyclesContent({super.key});

  @override
  Widget build(BuildContext context) {
    final _ = context.locale;
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdminDashboardTopContentWidget(title: "cycles"),
          SizedBox(height: 10),
          CyclesManagementScreen(),
        ],
      ),
    );
  }
}
