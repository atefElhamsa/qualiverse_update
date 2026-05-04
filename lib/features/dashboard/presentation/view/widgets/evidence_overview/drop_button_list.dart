import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final filtersCubit = context.read<DashboardFiltersCubit>();
    final dashboardCubit = context.read<DashboardCubit>();

    return SizedBox(
      width: 280.w,
      child: Column(
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
                    dashboardCubit: dashboardCubit,
                  );
                },
              );
            },
          ),

          SizedBox(height: 25.h),

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
                    dashboardCubit: dashboardCubit,
                  );
                },
              );
            },
          ),

          SizedBox(height: 25.h),

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
                    dashboardCubit: dashboardCubit,
                  );
                },
              );
            },
          ),

          SizedBox(height: 25.h),

          // Department
          BlocBuilder<DepartmentCubit, DepartmentState>(
            builder: (context, state) {
              List<DropdownMenuItem<int>> items = [];
              if (state is DepartmentSuccess) {
                items = state.departments
                    .map(
                      (e) => DropdownMenuItem(value: e.id, child: Text(e.name)),
                    )
                    .toList();
              }
              return CustomFilterDropdown<int>(
                hint: 'department'.tr(),
                value: filtersCubit.departmentId,
                items: items,
                onChanged: (v) {
                  filtersCubit.updateFilters(
                    departmentId: v,
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
