import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'first_part_evidence_overview.dart';

class EvidenceOverviewContent extends StatelessWidget {
  const EvidenceOverviewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FirstPartEvidenceOverview(),
          // SizedBox(height: 24),
          // EvidencePerCriterionChart(),
        ],
      ),
    );
  }
}
