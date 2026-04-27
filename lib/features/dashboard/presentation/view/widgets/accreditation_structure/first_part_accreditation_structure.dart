import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'courses_per_department_chart.dart';
import 'three_containers_right_accreditation_structure.dart';

class FirstPartAccreditationStructure extends StatelessWidget {
  const FirstPartAccreditationStructure({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const CoursesPerDepartmentChart(),
          SizedBox(width: 150.w),
          const ThreeContainersRightAccreditationStructure(),
        ],
      ),
    );
  }
}
