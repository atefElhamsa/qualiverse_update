import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class ArchiverAnalysisMainScreen extends StatelessWidget {
  const ArchiverAnalysisMainScreen({super.key, required this.courseArgs});

  final CourseArgs courseArgs;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomScaffoldTop(),
          const BigImageHomeWidget(),
          const SizedBox(height: 20),
          ArchiverAnalysisButtons(courseArgs: courseArgs),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
