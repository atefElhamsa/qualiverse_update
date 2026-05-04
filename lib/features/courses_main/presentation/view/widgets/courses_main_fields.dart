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
              final deptCubit = DepartmentCubit.get(context);
              if (state.selectedLevel!.levelNumber <= 2) {
                deptCubit.selectDepartment(department: null);
              } else {
                // If moving to level 3 or 4 and no department is selected, pick the first one
                if (deptCubit.selectedDepartment == null &&
                    deptCubit.state is DepartmentSuccess) {
                  final departments = (deptCubit.state as DepartmentSuccess).departments;
                  if (departments.isNotEmpty) {
                    deptCubit.selectDepartment(department: departments.first);
                  }
                }
              }
            }
          },
          child: const SelectedDepartmentWidget(checkLevel: true),
        ),
        const SelectedSemesterWidget(),
      ],
    );
  }
}
