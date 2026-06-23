import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_filters_cubit.dart';
import 'package:qualiverse/features/department/presentation/controller/academic_year_cubit.dart';
import 'package:qualiverse/features/department/presentation/controller/academic_year_state.dart';
import 'package:qualiverse/features/department/presentation/controller/department_cubit.dart';
import 'package:qualiverse/features/department/presentation/controller/department_state.dart';
import 'package:qualiverse/features/courses_main/presentation/controller/level/level_cubit.dart';
import 'package:qualiverse/features/courses_main/presentation/controller/level/level_state.dart';
import 'package:qualiverse/features/accreditation/presentation/controller/type_cubit.dart';
import 'package:qualiverse/features/accreditation/presentation/controller/type_state.dart';
import 'custom_filter_dropdown.dart';

class DropButtonList extends StatelessWidget {
  const DropButtonList({super.key});

  @override
  Widget build(BuildContext context) {
    final filtersCubit = context.watch<DashboardFiltersCubit>();
    final dashboardCubit = context.read<DashboardCubit>();

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Accreditation Type
          BlocBuilder<TypesCubit, TypesState>(
            builder: (context, state) {
              List<DropdownMenuItem<int>> items = [];
              if (state is TypesSuccess) {
                items = state.types
                    .map(
                      (e) => DropdownMenuItem(value: e.id, child: Text(e.name)),
                    )
                    .toList();
              }
              return CustomFilterDropdown<int>(
                hint: 'accreditationLabel'.tr(),
                value: filtersCubit.accreditationTypeId,
                items: items,
                onChanged: (v) {
                  filtersCubit.updateFilters(
                    accreditationTypeId: v,
                    clearAccreditation: v == null,
                    // If Institutional is selected, we might want to clear department automatically
                    clearDepartment:
                        v != null &&
                            state is TypesSuccess &&
                            state.types
                                .firstWhere(
                                  (e) => e.id == v,
                                  orElse: () => state.types.first,
                                )
                                .name
                                .toLowerCase()
                                .contains('institution')
                        ? true
                        : false,
                    dashboardCubit: dashboardCubit,
                  );
                },
              );
            },
          ),

          // Level
          BlocBuilder<LevelCubit, LevelState>(
            builder: (context, state) {
              List<DropdownMenuItem<int>> items = [];
              if (state is LevelSuccess) {
                items = state.levels
                    .map(
                      (e) => DropdownMenuItem(value: e.id, child: Text(e.name)),
                    )
                    .toList();
              }
              return CustomFilterDropdown<int>(
                hint: 'level'.tr(),
                value: filtersCubit.levelId,
                items: items,
                onChanged: (v) {
                  filtersCubit.updateFilters(
                    levelId: v,
                    clearLevel: v == null,
                    dashboardCubit: dashboardCubit,
                  );
                },
              );
            },
          ),

          // Year
          BlocBuilder<AcademicYearCubit, AcademicYearState>(
            builder: (context, state) {
              List<DropdownMenuItem<int>> items = [];
              if (state is AcademicYearSuccess) {
                items = state.academicYears
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.id,
                        child: Text(e.yearNumber.toString()),
                      ),
                    )
                    .toList();
              }
              return CustomFilterDropdown<int>(
                hint: 'year'.tr(),
                value: filtersCubit.yearId,
                items: items,
                onChanged: (v) {
                  filtersCubit.updateFilters(
                    yearId: v,
                    clearYear: v == null,
                    dashboardCubit: dashboardCubit,
                  );
                },
              );
            },
          ),

          // Department
          BlocBuilder<DepartmentCubit, DepartmentState>(
            builder: (context, state) {
              List<DropdownMenuItem<int>> items = [];

              // Check if Accreditation is Institutional
              bool isInstitutional = false;
              final typesState = context.read<TypesCubit>().state;
              if (typesState is TypesSuccess &&
                  filtersCubit.accreditationTypeId != null) {
                final selectedType = typesState.types.firstWhere(
                  (e) => e.id == filtersCubit.accreditationTypeId,
                  orElse: () => typesState.types.first,
                );
                if (selectedType.name.toLowerCase().contains('institution') ||
                    selectedType.name.contains('مؤسسي') ||
                    selectedType.id == 1) {
                  isInstitutional = true;
                }
              }

              // If institutional is selected, disable department completely
              if (isInstitutional) {
                return CustomFilterDropdown<int>(
                  hint: 'department'.tr(),
                  value: null,
                  items: const [],
                  onChanged: (v) {},
                );
              }

              if (state is DepartmentSuccess) {
                var availableDepartments = state.departments;

                // Check level constraint
                if (filtersCubit.levelId != null) {
                  final levelState = context.read<LevelCubit>().state;
                  if (levelState is LevelSuccess) {
                    final selectedLevel = levelState.levels.firstWhere(
                      (e) => e.id == filtersCubit.levelId,
                      orElse: () => levelState.levels.first,
                    );
                    final levelName = selectedLevel.name.toLowerCase();
                    bool isFirstOrSecond =
                        levelName.contains('first') ||
                        levelName.contains('second') ||
                        levelName.contains('اول') ||
                        levelName.contains('ثاني') ||
                        selectedLevel.id == 1 ||
                        selectedLevel.id == 2;

                    if (isFirstOrSecond && availableDepartments.length >= 4) {
                      availableDepartments = availableDepartments.sublist(4);
                    }
                  }
                }

                items = availableDepartments
                    .map(
                      (e) => DropdownMenuItem(value: e.id, child: Text(e.name)),
                    )
                    .toList();

                // Ensure selected department is still valid, else clear it
                if (filtersCubit.departmentId != null &&
                    !availableDepartments.any(
                      (d) => d.id == filtersCubit.departmentId,
                    )) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    filtersCubit.updateFilters(
                      clearDepartment: true,
                      dashboardCubit: dashboardCubit,
                    );
                  });
                }
              }

              return CustomFilterDropdown<int>(
                hint: 'department'.tr(),
                value: filtersCubit.departmentId,
                items: items,
                onChanged: (v) {
                  filtersCubit.updateFilters(
                    departmentId: v,
                    clearDepartment: v == null,
                    dashboardCubit: dashboardCubit,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
