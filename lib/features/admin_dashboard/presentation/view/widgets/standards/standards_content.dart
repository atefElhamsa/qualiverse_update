import 'package:flutter/material.dart';

import '../../../../../../routing/all_routes_imports.dart';

class StandardsContent extends StatelessWidget {
  const StandardsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [AdminDashboardTopContentWidget(title: "standards")],
    );
  }
}
