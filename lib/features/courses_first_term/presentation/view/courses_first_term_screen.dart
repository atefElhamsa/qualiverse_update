import 'package:flutter/material.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class CoursesFirstTermScreen extends StatelessWidget {
  const CoursesFirstTermScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainWrapper(child: CoursesFirstTermBody());
  }
}
