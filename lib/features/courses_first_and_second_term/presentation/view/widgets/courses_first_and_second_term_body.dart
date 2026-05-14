import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CoursesFirstAndSecondTermBody extends StatelessWidget {
  const CoursesFirstAndSecondTermBody({
    super.key,
    required this.title,
    required this.courseArgs,
  });

  final String title;
  final CourseArgs courseArgs;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      onRefresh: () async{
        context.read<CourseCubit>().fetchCourses(
          yearId: courseArgs.yearId,
          levelId: courseArgs.levelId,
          semesterId: courseArgs.termModel.id,
          departmentId: courseArgs.departmentId,
        );
      },
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FirstTermTopAndTitle(tile: title, courseArgs: courseArgs),
          const SizedBox(height: 22),
          const CoursesList(),
        ],
      ),
    );
  }
}
