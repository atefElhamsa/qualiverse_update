import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class ArchiverAnalysisButtons extends StatelessWidget {
  const ArchiverAnalysisButtons({super.key, required this.courseArgs});

  final CourseArgs courseArgs;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ArchiverButton(courseArgs: courseArgs),
            const SizedBox(width: 90),
            const AnalysisButton(),
          ],
        ),
      ),
    );
  }
}
