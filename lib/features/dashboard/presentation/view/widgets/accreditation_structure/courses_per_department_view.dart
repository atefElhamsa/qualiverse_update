import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../routing/all_routes_imports.dart';

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
        final maxValue = data
            .map((d) => d.value)
            .reduce((a, b) => a > b ? a : b);

        return Container(
          width: double.infinity,
          constraints: const BoxConstraints(maxWidth: 800),
          decoration: BoxDecoration(
            color: AppColors.grey,
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
                title: 'Courses per Department',
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
                      title: 'Count of Courses Name',
                      textStyle: Theme.of(
                        context,
                      ).textTheme.headlineLarge!.copyWith(fontSize: 13.sp),
                    ),
                  ),
                  const SizedBox(width: 6),
                  // Bars
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(data.length, (i) {
                        return DepartmentBar(
                          item: data[i],
                          maxValue: maxValue,
                          maxHeight: 180,
                          delay: Duration(milliseconds: i * 120),
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
}
