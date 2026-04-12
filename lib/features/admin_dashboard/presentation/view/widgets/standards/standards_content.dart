import 'package:flutter/material.dart';

import '../../../../../../routing/all_routes_imports.dart';

class StandardsContent extends StatelessWidget {
  const StandardsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdminDashboardTopContentWidget(title: "standards"),
          SizedBox(height: 20),
          StandardsIndicatorScreen(
            items: [
              StandardsIndicatorModel(
                standard: 'Teaching Quality',
                indicator: 'Library Resources',
                status: 'Completed',
              ),
              StandardsIndicatorModel(
                standard: 'Learning Resources',
                indicator: 'Faculty Evaluation',
                status: 'In Progress',
              ),
              StandardsIndicatorModel(
                standard: 'Teaching Quality',
                indicator: 'Library Resources',
                status: 'In Progress',
              ),
              StandardsIndicatorModel(
                standard: 'Learning Resources',
                indicator: 'Faculty Evaluation',
                status: 'Completed',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
