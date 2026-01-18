import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../routing/all_routes_imports.dart';

class FirstPartEvidenceOverview extends StatefulWidget {
  const FirstPartEvidenceOverview({super.key});

  @override
  State<FirstPartEvidenceOverview> createState() =>
      _FirstPartEvidenceOverviewState();
}

class _FirstPartEvidenceOverviewState extends State<FirstPartEvidenceOverview> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Image.asset(AppImages.evidenceOverview, fit: BoxFit.cover),
          SizedBox(width: 28.w),
          const DropButtonList(),
          SizedBox(width: 80.w),
          const ThreeContainersRightEvidenceOverview(),
        ],
      ),
    );
  }
}
