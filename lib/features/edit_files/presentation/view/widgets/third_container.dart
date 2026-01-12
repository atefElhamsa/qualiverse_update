import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class ThirdContainer extends StatelessWidget {
  const ThirdContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ContainerWidget(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemTextWidgetForContainer(title: "midtermExam"),
              SizedBox(width: 24.w),
              ItemTextWidgetForContainer(title: "finalExam"),
            ],
          ),
          SizedBox(height: 24.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemTextWidgetForContainer(title: "studentWorkCopy"),
              SizedBox(width: 24.w),
              ItemTextWidgetForContainer(title: "ExamPaperAnalysis"),
            ],
          ),
        ],
      ),
    );
  }
}
