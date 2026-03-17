import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class EditFilesScreen extends StatelessWidget {
  const EditFilesScreen({super.key, required this.courseFolderArgs});

  final CourseFolderArgs courseFolderArgs;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CourseFolderCubit()
            ..fetchCourseFolders(courseId: courseFolderArgs.courseModel.id),
      child: const MainWrapper(child: EditFilesBody()),
    );
  }
}
