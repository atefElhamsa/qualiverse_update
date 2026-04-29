import 'package:flutter/material.dart';

import '../../../../../../routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class UsersContent extends StatelessWidget {
  const UsersContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdminDashboardTopContentWidget(title: "users"),
          const SizedBox(height: 10),
          const UserManagementScreen(),
        ],
      ),
    );
  }
}
