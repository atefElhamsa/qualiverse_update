import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CoursesFirstTermBody extends StatelessWidget {
  const CoursesFirstTermBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FirstTermTopAndTitle(),
          const SizedBox(height: 22),
          const CoursesList(),
          Padding(
            padding: EdgeInsets.only(top: 50.h, bottom: 10.w),
            child: FirstAndSecondTermButton(
              title: "secondTerm",
              mainAxisAlignment: MainAxisAlignment.end,
              onPressed: () {
                context.pushNamed(AppRoutes.coursesSecondTermScreen);
              },
            ),
          ),
        ],
      ),
    );
  }
}
