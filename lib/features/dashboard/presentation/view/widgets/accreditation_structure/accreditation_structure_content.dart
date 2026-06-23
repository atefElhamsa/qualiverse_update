import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'first_part_accreditation_structure.dart';

class AccreditationStructureContent extends StatelessWidget {
  const AccreditationStructureContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FirstPartAccreditationStructure(),
          // SizedBox(height: 24),
          // EvidencePerCriterionChart(),
        ],
      ),
    );
  }
}
