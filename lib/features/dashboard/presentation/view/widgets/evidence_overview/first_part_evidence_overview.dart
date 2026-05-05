import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'evidence_status_chart.dart';
import 'drop_button_list.dart';
import 'three_containers_right_evidence_overview.dart';

class FirstPartEvidenceOverview extends StatelessWidget {
  const FirstPartEvidenceOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.start,
        runSpacing: 30.h,
        children: [
          const EvidenceStatusChart(),
          const DropButtonList(),
          const EvidenceSummaryCards(),
        ],
      ),
    );
  }
}
