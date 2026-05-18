import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class SelectedDepartmentWidget extends StatelessWidget {
  final bool checkLevel;
  const SelectedDepartmentWidget({super.key, this.checkLevel = false});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelCubit, LevelState>(
      builder: (context, levelState) {
        final level = levelState is LevelSuccess
            ? levelState.selectedLevel
            : null;
        final bool isLevel1Or2 = level != null && level.levelNumber <= 2;

        return BlocBuilder<DepartmentCubit, DepartmentState>(
          builder: (context, state) {
            if (state is DepartmentLoading) {
              return const CustomLoading();
            }
            if (state is DepartmentError) {
              return RetryWidget(
                title: state.message,
                onPressed: () {
                  DepartmentCubit.get(context).fetchDepartments();
                },
              );
            }
            if (state is DepartmentSuccess) {
              final departmentCubit = DepartmentCubit.get(context);

              final List<String> departmentNames = state.departments
                  .map((e) => e.name)
                  .toList();

              bool isDataAnalysis(String name) {
                final lower = name.toLowerCase();
                return lower.contains("data analysis") ||
                    lower.contains("تحليل البيانات");
              }

              final List<String> disabledDepts = isLevel1Or2
                  ? departmentNames
                        .where((name) => !isDataAnalysis(name))
                        .toList()
                  : [];

              final String? selectedDepartmentName =
                  state.selectedDepartment?.name;

              return CustomDropButtonAndTitle(
                dropButtonModel: DropButtonModel(
                  selectedData: selectedDepartmentName,
                  listOfData: departmentNames,
                  disabledItems: disabledDepts,
                  hintText: "selectTheDepartment".tr(),
                  hintSize: 20.sp,
                  onChanged: (value) {
                    if (value == null) return;
                    final selectedModel = state.departments.firstWhere(
                      (d) => d.name == value,
                    );
                    departmentCubit.selectDepartment(department: selectedModel);
                  },
                ),
                title: "department".tr(),
              );
            }
            return const SizedBox();
          },
        );
      },
    );
  }
}
