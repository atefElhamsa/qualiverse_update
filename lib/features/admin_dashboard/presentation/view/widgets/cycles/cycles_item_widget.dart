import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';

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
                height: 36.h,
                width: 80.w,
                child: OutlinedButton(
                  onPressed: () {
                    context.read<AdminDashboardCubit>().openCycleDetails(
                      cycleId: academicYear.id,
                    );
                    context.read<AcademicYearCubit>().selectAcademicYear(
                      academicYear: academicYear,
                    );
                    context.read<DepartmentCubit>().fetchDepartments();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF2C2C3E),
                    side: const BorderSide(color: Color(0xFFBBBBCC), width: 1),
                    padding: EdgeInsets.zero,
                    minimumSize: Size(70.w, 32.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: CustomText(
                    title: 'view'.tr(),
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
