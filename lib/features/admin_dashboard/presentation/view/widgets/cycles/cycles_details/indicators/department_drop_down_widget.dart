import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../routing/all_routes_imports.dart';

class DepartmentDropDownWidget extends StatefulWidget {
  const DepartmentDropDownWidget({super.key});

  @override
  State<DepartmentDropDownWidget> createState() =>
      _DepartmentDropDownWidgetState();
}

class _DepartmentDropDownWidgetState extends State<DepartmentDropDownWidget> {
  @override
  void initState() {
    super.initState();
    DepartmentCubit.get(context).fetchDepartments();
  }

  @override
  void didChangeDependencies() {
    DepartmentCubit.get(context).reset();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
          final departments = state.departments;
          final isValid = departments.any(
            (e) => e.id == state.selectedDepartment?.id,
          );
          return Container(
            height: 54.h,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFCCCCCC)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: isValid ? state.selectedDepartment?.id : null,
                hint: Text('selectTheDepartment'.tr()),
                icon: Icon(Icons.keyboard_arrow_down, size: 20.sp),
                style: TextStyle(
                  fontSize: 15.sp,
                  color: const Color(0xFF333333),
                ),
                items: departments
                    .map(
                      (department) => DropdownMenuItem<int>(
                        value: department.id,
                        child: Text(
                          department.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) return;
                  final selectedModel = state.departments.firstWhere(
                    (d) => d.id == value,
                  );
                  departmentCubit.selectDepartment(department: selectedModel);
                  context
                      .read<ProgramAccreditationCubit>()
                      .fetchProgramAccreditations(
                        academicYearId: AcademicYearCubit.get(
                          context,
                        ).selectedAcademicYear!.id,
                        departmentId: value,
                      );
                  context.read<CycleIndicatorCubit>().fetchCycleIndicators(
                    yearId: AcademicYearCubit.get(
                      context,
                    ).selectedAcademicYear!.id,
                    departmentId: value,
                  );
                },
              ),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
