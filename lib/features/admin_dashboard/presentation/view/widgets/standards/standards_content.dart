import 'package:flutter/material.dart';

import '../../../../../../routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class StandardsContent extends StatelessWidget {
  const StandardsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdminDashboardTopContentWidget(title: "standards"),
          const SizedBox(height: 20),
          const StandardsIndicatorScreen(
            items: [
              StandardsIndicatorModel(
                standard: 'teachingQuality',
                indicator: 'libraryResources',
                status: 'completed',
              ),
              StandardsIndicatorModel(
                standard: 'learningResources',
                indicator: 'facultyEvaluation',
                status: 'inProgress',
              ),
              StandardsIndicatorModel(
                standard: 'teachingQuality',
                indicator: 'libraryResources',
                status: 'inProgress',
              ),
              StandardsIndicatorModel(
                standard: 'learningResources',
                indicator: 'facultyEvaluation',
                status: 'completed',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
