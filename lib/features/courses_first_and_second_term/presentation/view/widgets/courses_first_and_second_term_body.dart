import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CoursesFirstAndSecondTermBody extends StatelessWidget {
  const CoursesFirstAndSecondTermBody({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FirstTermTopAndTitle(tile: title),
          const SizedBox(height: 22),
          const CoursesList(),
        ],
      ),
    );
  }
}
