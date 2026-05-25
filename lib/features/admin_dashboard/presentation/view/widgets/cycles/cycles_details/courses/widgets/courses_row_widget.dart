import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CoursesRowWidget extends StatelessWidget {
  const CoursesRowWidget({
    super.key,
    required this.course,
    required this.index,
    required this.total,
  });

  final CourseItemModel course;
  final int index;
  final int total;

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 900;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        isSmall
            ? buildCourseCard(context, course)
            : buildCourseRow(context, course),
        if (index < total - 1 && !isSmall)
          const Divider(height: 1, thickness: 1, color: AppColors.grey),
      ],
    );
  }
}
