import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';
import 'package:qualiverse/routing/app_routes.dart';

class CourseSpecificationFirstTermBody extends StatelessWidget {
  const CourseSpecificationFirstTermBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CourseSpecificationTop(),
          const SizedBox(height: 22),
          const CoursesList(),
          Padding(
            padding: EdgeInsets.only(top: 50.h, bottom: 10.w),
            child: FirstAndSecondTermButton(
              mainAxisAlignment: MainAxisAlignment.end,
              title: "secondTerm",
              onPressed: () {
                context.pushNamed(
                  AppRoutes.courseSpecificationSecondTermScreen,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
