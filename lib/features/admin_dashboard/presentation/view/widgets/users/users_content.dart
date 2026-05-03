import 'package:flutter/material.dart';

import '../../../../../../routing/all_routes_imports.dart';

class UsersContent extends StatelessWidget {
  const UsersContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdminDashboardTopContentWidget(title: "users"),
          SizedBox(height: 10),
          UserManagementScreen(),
        ],
      ),
    );
  }
}
