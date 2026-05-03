import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../routing/all_routes_imports.dart';

class CyclesDetailsTapsWidget extends StatelessWidget {
  const CyclesDetailsTapsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CycleTabsCubit, CycleTabsState>(
      builder: (context, state) {
        final cubit = context.read<CycleTabsCubit>();
        return Row(
          children: CycleTab.values.map((tab) {
            final isSelected = cubit.currentTab == tab;
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  cubit.changeTab(tab);
                  DepartmentCubit.get(context).selectDepartment(
                    department: null,
                  );
                  LevelCubit.get(context).selectLevel(level: null);
                  TermCubit.get(context).selectTerm(term: null);

                  CoursesCubit.get(context).emit(CoursesInitial());
                  CriterionsCubit.get(context).emit(CriterionsInitial());
                },
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 30.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: CustomText(
                          title: tab.name.tr(),
                          textStyle: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: isSelected
                                ? AppColors.blue
                                : AppColors.mainGrey,
                          ),
                        ),
                      ),

                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        height: 3,
                        width: isSelected ? 80.w : 0, // Simplified width logic
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
