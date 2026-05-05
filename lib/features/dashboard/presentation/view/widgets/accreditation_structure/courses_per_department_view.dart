import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/courses_per_department/courses_per_department_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/courses_per_department/courses_per_department_state.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'department_bars.dart';
import 'package:easy_localization/easy_localization.dart';

class CoursesPerDepartmentView extends StatelessWidget {
  const CoursesPerDepartmentView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoursesPerDepartmentCubit, CoursesPerDepartmentState>(
      builder: (context, state) {
        if (state is! CoursesPerDepartmentLoaded) {
          return const SizedBox.shrink();
        }
        final data = state.data;
        final maxValue = data.isEmpty ? 1.0 : data.map((d) => d.value).reduce((a, b) => a > b ? a : b);
        final displayMaxValue = maxValue == 0 ? 1.0 : maxValue;

        return Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 800),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
                ? AppColors.grey
                : AppColors.mainBlack,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: const Offset(0, 4),
                spreadRadius: 0,
                blurRadius: 4,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              CustomText(
                title: 'coursesPerDepartment'.tr(),
                textStyle: Theme.of(
                  context,
                ).textTheme.headlineLarge!.copyWith(fontSize: 16.sp),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Y-axis label
                  RotatedBox(
                    quarterTurns: 3,
                    child: CustomText(
                      title: 'countOfCoursesName'.tr(),
                      textStyle: Theme.of(
                        context,
                      ).textTheme.headlineLarge!.copyWith(fontSize: 13.sp),
                    ),
                  ),
                  const SizedBox(width: 6),
                  // Bars
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: data.isEmpty
                          ? List.generate(5, (i) => _buildSkeletonBar(context))
                          : List.generate(data.length, (i) {
                              return DepartmentBar(
                                item: data[i],
                                maxValue: displayMaxValue,
                                maxHeight: 180.h,
                                delay: Duration(milliseconds: i * 100),
                              );
                            }),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
  Widget _buildSkeletonBar(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 40.w,
            height: 100.h,
            decoration: BoxDecoration(
              color: AppColors.textGrey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(3.r),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 30.w,
            height: 10.h,
            decoration: BoxDecoration(
              color: AppColors.textGrey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
