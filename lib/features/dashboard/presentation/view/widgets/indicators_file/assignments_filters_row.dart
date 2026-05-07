import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/department/presentation/controller/academic_year_cubit.dart';
import 'package:qualiverse/features/department/presentation/controller/academic_year_state.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/controller/cycles/assignments/assignment_status_cubit.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/controller/cycles/assignments/assignment_status_state.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/assignmets/assignments_user_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import '../evidence_overview/custom_filter_dropdown.dart';

class AssignmentsFiltersRow extends StatelessWidget {
  const AssignmentsFiltersRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Year Filter
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: 'academicYear'.tr(),
                  textStyle: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: 8.h),
                BlocBuilder<AcademicYearCubit, AcademicYearState>(
                  builder: (context, state) {
                    final cubit = AcademicYearCubit.get(context);
                    return CustomFilterDropdown<int>(
                      hint: 'year'.tr(),
                      value: cubit.selectedAcademicYear?.id,
                      items: cubit.academicYears.map((year) {
                        return DropdownMenuItem<int>(
                          value: year.id,
                          child: Text(year.yearNumber.toString()),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val == null) return;
                        final selectedYear = cubit.academicYears.firstWhere((e) => e.id == val);
                        cubit.selectAcademicYear(academicYear: selectedYear);
                        context.read<AssignmentsUserCubit>().getAssignments(
                          academicYearId: selectedYear.id,
                          status: context.read<AssignmentStatusCubit>().selectedStatus?.value,
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          SizedBox(width: 20.w),
          // Status Filter
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: 'status'.tr(),
                  textStyle: GoogleFonts.inter(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                SizedBox(height: 8.h),
                BlocBuilder<AssignmentStatusCubit, AssignmentStatusState>(
                  builder: (context, state) {
                    final cubit = context.read<AssignmentStatusCubit>();
                    return CustomFilterDropdown<int?>(
                      hint: 'status'.tr(),
                      value: cubit.selectedStatus?.value,
                      items: [
                        DropdownMenuItem<int?>(
                          value: null,
                          child: Text('all'.tr()),
                        ),
                        ...cubit.statuses.map((status) {
                          return DropdownMenuItem<int?>(
                            value: status.value,
                            child: Text(status.name.toLowerCase().tr()),
                          );
                        }),
                      ],
                      onChanged: (val) {
                        if (val == null) {
                          cubit.resetSelection();
                        } else {
                          final selectedStatus = cubit.statuses.firstWhere((e) => e.value == val);
                          cubit.selectStatus(selectedStatus);
                        }
                        
                        final yearId = context.read<AcademicYearCubit>().selectedAcademicYear?.id;
                        if (yearId != null) {
                          context.read<AssignmentsUserCubit>().getAssignments(
                            academicYearId: yearId,
                            status: val,
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          const Spacer(flex: 5),
        ],
      ),
    );
  }
}
