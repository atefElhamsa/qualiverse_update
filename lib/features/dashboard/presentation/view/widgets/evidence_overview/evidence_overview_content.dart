import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class EvidenceOverviewContent extends StatelessWidget {
  const EvidenceOverviewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FirstPartEvidenceOverview(),
            SizedBox(height: 24),
            EvidencePerCriterionChart(
              data: [
                CriterionDataModel(label: 'Criterion A', value: 5),
                CriterionDataModel(label: 'Criterion B', value: 3),
                CriterionDataModel(label: 'Criterion C', value: 8),
                CriterionDataModel(label: 'Criterion D', value: 2),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
