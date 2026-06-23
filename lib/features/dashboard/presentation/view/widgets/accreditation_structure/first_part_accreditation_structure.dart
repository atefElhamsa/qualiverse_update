import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'courses_per_department_chart.dart';
import 'three_containers_right_accreditation_structure.dart';

class FirstPartAccreditationStructure extends StatelessWidget {
  const FirstPartAccreditationStructure({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Expanded(flex: 14, child: CoursesPerDepartmentChart()),
            SizedBox(width: 20.w),
            const Expanded(flex: 6, child: ThreeContainersRightAccreditationStructure()),
          ],
        ),
      ),
    );
  }
}
