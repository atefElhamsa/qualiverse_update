import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class CoursesFirstAndSecondTermScreen extends StatelessWidget {
  const CoursesFirstAndSecondTermScreen({super.key, required this.courseArgs});

  final CourseArgs courseArgs;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CourseCubit()
            ..fetchCourses(
              yearId: courseArgs.yearId,
              levelId: courseArgs.levelId,
              semesterId: courseArgs.termModel.id,
              departmentId: courseArgs.departmentId,
            ),
        ),
        BlocProvider(create: (context) => EvidenceFolderFilesCubit()),
      ],
      child: MainWrapper(
        disableDrawer: true,
        child: CoursesFirstAndSecondTermBody(
          title: courseArgs.termModel.name,
          courseArgs: courseArgs,
        ),
      ),
    );
  }
}
