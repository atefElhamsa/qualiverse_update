import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class CoursesMainFields extends StatelessWidget {
  const CoursesMainFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SelectedAcademicYearWidget(),
        SizedBox(height: 20.h),
        const SelectedLevelWidget(),
        SizedBox(height: 20.h),
        MultiBlocListener(
          listeners: [
            BlocListener<LevelCubit, LevelState>(
              listener: (context, state) {
                if (state is LevelSuccess && state.selectedLevel != null) {
                  final deptCubit = DepartmentCubit.get(context);
                  if (state.selectedLevel!.levelNumber <= 2) {
                    final deptName =
                        deptCubit.selectedDepartment?.name.toLowerCase() ?? '';
                    final isDataAnalysis =
                        deptName.contains("data analysis") ||
                        deptName.contains("تحليل البيانات");
                    if (deptCubit.selectedDepartment != null && !isDataAnalysis) {
                      deptCubit.selectDepartment(department: null);
                    }
                  } else {
                    if (deptCubit.selectedDepartment == null &&
                        deptCubit.state is DepartmentSuccess) {
                      final departments =
                          (deptCubit.state as DepartmentSuccess).departments;
                      if (departments.isNotEmpty) {
                        deptCubit.selectDepartment(department: departments.first);
                      }
                    }
                  }
                }
              },
            ),
            BlocListener<DepartmentCubit, DepartmentState>(
              listener: (context, state) {
                if (state is DepartmentSuccess) {
                  final levelCubit = LevelCubit.get(context);
                  if (levelCubit.selectedLevel != null &&
                      levelCubit.selectedLevel!.levelNumber <= 2) {
                    final deptName =
                        state.selectedDepartment?.name.toLowerCase() ?? '';
                    final isDataAnalysis =
                        deptName.contains("data analysis") ||
                        deptName.contains("تحليل البيانات");
                    if (state.selectedDepartment != null && !isDataAnalysis) {
                      DepartmentCubit.get(context)
                          .selectDepartment(department: null);
                    }
                  }
                }
              },
            ),
          ],
          child: const SelectedDepartmentWidget(),
        ),
        SizedBox(height: 20.h),
        const SelectedSemesterWidget(),
      ],
    );
  }
}
