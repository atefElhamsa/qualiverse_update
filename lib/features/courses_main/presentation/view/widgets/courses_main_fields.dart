import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class CoursesMainFields extends StatelessWidget {
  const CoursesMainFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SelectedAcademicYearWidget(),
        const SelectedLevelWidget(),
        BlocListener<LevelCubit, LevelState>(
          listener: (context, state) {
            if (state is LevelSuccess && state.selectedLevel != null) {
              if (state.selectedLevel!.levelNumber <= 2) {
                DepartmentCubit.get(context).selectDepartment(department: null);
              }
            }
          },
          child: const SelectedDepartmentWidget(),
        ),
        const SelectedSemesterWidget(),
      ],
    );
  }
}
