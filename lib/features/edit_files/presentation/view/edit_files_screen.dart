import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class EditFilesScreen extends StatelessWidget {
  const EditFilesScreen({super.key, required this.courseFolderArgs});

  final CourseFolderArgs courseFolderArgs;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CourseFolderCubit()
            ..fetchCourseFolders(courseId: courseFolderArgs.courseModel.id),
        ),
        BlocProvider(
          create: (context) => EvidenceFolderCubit()..fetchEvidenceFolders(),
        ),
      ],
      child: MainWrapper(
        child: EditFilesBody(courseModel: courseFolderArgs.courseModel),
      ),
    );
  }
}
