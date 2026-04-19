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
                onTap: () => cubit.changeTab(tab),
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 50.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: CustomText(
                          title: tab.name.capitalizeFirst(),
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
                        width: isSelected
                            ? getTextWidth(tab.name.capitalizeFirst())
                            : 0,
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
