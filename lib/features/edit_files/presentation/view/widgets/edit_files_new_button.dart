import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../routing/all_routes_imports.dart';

class EditFilesNewButton extends StatelessWidget {
  const EditFilesNewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return NewButton(
      title: context.locale.languageCode == 'ar' ? 'مجلد جديد' : 'New Folder',
      onTap: () {
        final courseId = CourseFolderCubit.get(context).currentCourseId;
        if (courseId == null) return;

        final courseFolderCubit = CourseFolderCubit.get(context);
        final createFolderCubit = CreateFolderCubit.get(context);

        showDialog(
          context: context,
          builder: (context) => ShowCreateFolderDialog(
            courseFolderCubit: courseFolderCubit,
            courseId: courseId,
            createFolderCubit: createFolderCubit,
          ),
        );
      },
    );
  }
}
