import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../routing/all_routes_imports.dart';

class DashboardAcademicYearDropdown extends StatelessWidget {
  const DashboardAcademicYearDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AcademicYearCubit, AcademicYearState>(
      builder: (context, state) {
        if (state is AcademicYearLoading) {
          return SizedBox(
            width: 150.w,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        if (state is AcademicYearError) {
          return IconButton(
            onPressed: () =>
                AcademicYearCubit.get(context).fetchAcademicYears(),
            icon: const Icon(Icons.refresh),
            tooltip: state.message,
          );
        }
        if (state is AcademicYearSuccess) {
          final academicYearCubit = AcademicYearCubit.get(context);
          final List<int> yearNumbers = state.academicYears
              .map((e) => e.yearNumber)
              .toList();

          final int? selectedYearNumber =
              state.selectedAcademicYear?.yearNumber;

          return Container(
            width: 180.w,
            height: 45.h,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: AppColors.blue.withOpacity(0.2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                value: selectedYearNumber,
                hint: Text(
                  state.academicYears.isEmpty ? "noYears".tr() : "selectedYear".tr(),
                  style: TextStyle(fontSize: 15.sp, color: AppColors.textGrey),
                ),
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.blue,
                  size: 24.sp,
                ),
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                items: yearNumbers.map((int year) {
                  return DropdownMenuItem<int>(
                    value: year,
                    child: Text(
                      year.toString(),
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blue,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value == null) return;
                  final selectedModel = state.academicYears.firstWhere(
                    (d) => d.yearNumber == value,
                  );
                  academicYearCubit.selectAcademicYear(
                    academicYear: selectedModel,
                  );

                  // Refresh dashboard data
                  context.read<DashboardOverviewCubit>().getAllDashboardData(
                    yearId: selectedModel.id,
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
