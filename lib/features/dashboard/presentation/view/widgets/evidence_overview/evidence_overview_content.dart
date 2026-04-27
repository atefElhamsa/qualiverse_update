import 'package:flutter/material.dart';
import 'first_part_evidence_overview.dart';
import 'evidence_per_criterion_chart.dart';

class EvidenceOverviewContent extends StatelessWidget {
  const EvidenceOverviewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FirstPartEvidenceOverview(),
          SizedBox(height: 24),
          EvidencePerCriterionChart(),
        ],
      ),
    );
  }
}
