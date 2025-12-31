import 'package:flutter/material.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class CoursesList extends StatelessWidget {
  const CoursesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(4, (index) {
            return CourseItemWidget(title: coursesRow1[index].title);
          }),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(4, (index) {
            return CourseItemWidget(title: coursesRow2[index].title);
          }),
        ),
      ],
    );
  }
}
