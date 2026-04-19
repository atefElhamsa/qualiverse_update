import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CyclesItemWidget extends StatelessWidget {
  const CyclesItemWidget({
    super.key,
    required this.academicYear,
    required this.index,
    required this.total,
  });

  final AcademicYearModel academicYear;
  final int index;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: CustomText(
                  title: academicYear.yearNumber.toString(),
                  textStyle: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(fontSize: 16.sp),
                ),
              ),
              SizedBox(
                height: 40.h,
                width: 62.w,
                child: OutlinedButton(
                  onPressed: () {
                    context.read<AdminDashboardCubit>().openCycleDetails(
                      cycleId: academicYear.id,
                    );
                    context.read<AcademicYearCubit>().selectAcademicYear(
                      academicYear: academicYear,
                    );
                    context.read<DepartmentCubit>().fetchDepartments();
                    context.read<CycleIndicatorCubit>().fetchCycleIndicators(
                      yearId: academicYear.id,
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF2C2C3E),
                    side: const BorderSide(color: Color(0xFFBBBBCC), width: 1),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    minimumSize: const Size(60, 32),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: CustomText(
                    title: 'View',
                    textStyle: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(fontSize: 13.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (index < total - 1)
          const Divider(height: 1, thickness: 1, color: AppColors.grey),
      ],
    );
  }
}
