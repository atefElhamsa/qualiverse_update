import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class CoursesSecondTermBody extends StatelessWidget {
  const CoursesSecondTermBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SecondTermTopAndTitle(),
          const SizedBox(height: 22),
          const CoursesList(),
          Padding(
            padding: EdgeInsets.only(top: 50.h, bottom: 10.w),
            child: FirstAndSecondTermButton(
              title: "firstTerm",
              mainAxisAlignment: MainAxisAlignment.end,
              onPressed: () {
                context.pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
