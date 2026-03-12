import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class CoursesFirstAndSecondTermScreen extends StatelessWidget {
  const CoursesFirstAndSecondTermScreen({super.key, required this.courseArgs});

  final CourseArgs courseArgs;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseCubit()
        ..fetchCourses(
          yearId: courseArgs.yearId,
          levelId: courseArgs.levelId,
          semesterId: courseArgs.semesterModel.id,
          departmentId: courseArgs.departmentId,
        ),
      child: MainWrapper(
        child: CoursesFirstAndSecondTermBody(
          title: courseArgs.semesterModel.name,
        ),
      ),
    );
  }
}
