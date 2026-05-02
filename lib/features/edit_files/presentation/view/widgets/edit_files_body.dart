import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'evidence_folders_section.dart';

class EditFilesBody extends StatelessWidget {
  final CourseModel courseModel;
  const EditFilesBody({super.key, required this.courseModel});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      widget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const EditFilesTopAndTitle(),
          const EditFilesNewButton(),
          const SizedBox(height: 20),
          EvidenceFoldersSection(
            departmentId: courseModel.departmentId,
            yearId: courseModel.academicYearId,
            termId: courseModel.termId,
            levelId: courseModel.levelId,
            courseId: courseModel.id,
          ),
          const EditFilesList(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
