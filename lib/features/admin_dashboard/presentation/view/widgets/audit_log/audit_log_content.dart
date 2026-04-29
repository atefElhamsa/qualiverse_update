import 'package:flutter/material.dart';

import '../../../../../../routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class AuditLogContent extends StatelessWidget {
  const AuditLogContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [AdminDashboardTopContentWidget(title: "auditLog")],
    );
  }
}
