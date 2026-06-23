import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'evidence_status_chart.dart';
import 'drop_button_list.dart';
import 'three_containers_right_evidence_overview.dart';

class FirstPartEvidenceOverview extends StatelessWidget {
  const FirstPartEvidenceOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(flex: 13, child: EvidenceStatusChart()),
            SizedBox(width: 20.w),
            const Expanded(flex: 8, child: DropButtonList()),
            SizedBox(width: 20.w),
            const Expanded(flex: 7, child: EvidenceSummaryCards()),
          ],
        ),
      ),
    );
  }
}
