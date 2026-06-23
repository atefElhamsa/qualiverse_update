import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
                ? AppColors.white
                : AppColors.mainBlack,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                offset: const Offset(0, 10),
                blurRadius: 30,
                spreadRadius: 0,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              CustomText(
                title: 'coursesPerDepartment'.tr(),
                textStyle: Theme.of(
                  context,
                ).textTheme.headlineLarge!.copyWith(fontSize: 13.sp),
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
                  // Bars and Labels
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Bars Row
                        Row(
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
                        if (data.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          // Labels Row
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(data.length, (i) {
                              return Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: CustomText(
                                    title: data[i].label,
                                    textAlign: TextAlign.center,
                                    textStyle: GoogleFonts.inter(
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
                                          ? AppColors.textGrey
                                          : AppColors.white.withOpacity(0.75),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ],
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
            width: 45.w,
            height: 100.h,
            decoration: BoxDecoration(
              color: AppColors.textGrey.withOpacity(0.05),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(6.r),
                topRight: Radius.circular(6.r),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: 35.w,
            height: 8.h,
            decoration: BoxDecoration(
              color: AppColors.textGrey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ],
      ),
    );
  }
}
