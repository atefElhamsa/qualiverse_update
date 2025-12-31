import 'package:flutter/material.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class CoursesMainScreen extends StatelessWidget {
  const CoursesMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainWrapper(child: CoursesMainBody());
  }
}
