import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'courses_header.dart';
import 'courses_row_widget.dart';

class CoursesTable extends StatelessWidget {
  final List<CourseItemModel> courses;
  const CoursesTable({super.key, required this.courses});

  @override
  Widget build(BuildContext context) {
    if (courses.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: CustomText(
            title: 'No Courses Available',
            textStyle: Theme.of(context).textTheme.headlineLarge!,
          ),
        ),
      );
    }

    return Column(
      children: [
        const CoursesHeader(),
        ...courses.asMap().entries.map(
          (entry) => CoursesRowWidget(
            course: entry.value,
            index: entry.key,
            total: courses.length,
          ),
        ),
      ],
    );
  }
}
