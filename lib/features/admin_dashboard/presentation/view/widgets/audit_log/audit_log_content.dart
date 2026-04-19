import 'package:flutter/material.dart';

import '../../../../../../routing/all_routes_imports.dart';

class AuditLogContent extends StatelessWidget {
  const AuditLogContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [AdminDashboardTopContentWidget(title: "auditLog")],
    );
  }
}
