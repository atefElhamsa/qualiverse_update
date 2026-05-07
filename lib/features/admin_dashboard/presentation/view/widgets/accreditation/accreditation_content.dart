import 'package:flutter/material.dart';

import '../../../../../../routing/all_routes_imports.dart';

class AccreditationContent extends StatelessWidget {
  const AccreditationContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [AdminDashboardTopContentWidget(title: "accreditation")],
    );
  }
}
