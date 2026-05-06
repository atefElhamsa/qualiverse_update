import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/features/dashboard/data/models/dashboard_response_model.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_state.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class ThreeContainersRightAccreditationStructure extends StatelessWidget {
  const ThreeContainersRightAccreditationStructure({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        AccreditationStructure? structure;
        if (state is DashboardSuccess) {
          structure = state.data.accreditationStructure;
        }

        final data = [
          {
            "title": "totalIndicators",
            "count": structure?.totalIndicators ?? 0,
            "icon": Icons.track_changes_rounded,
            "color": AppColors.blue,
          },
          {
            "title": "totalCriteria",
            "count": structure?.totalCriteria ?? 0,
            "icon": Icons.fact_check_rounded,
            "color": AppColors.green,
          },
          {
            "title": "totalCourses",
            "count": structure?.totalCourses ?? 0,
            "icon": Icons.auto_stories_rounded,
            "color": AppColors.orange,
          },
        ];

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(data.length, (index) {
            final item = data[index];
            return Container(
                  width: 214.w,
                  height: 85.h,
                  margin: EdgeInsets.only(bottom: index == 2 ? 0 : 30.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: (item['color'] as Color).withOpacity(0.12),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                    border: Border.all(
                      color: (item['color'] as Color).withOpacity(0.1),
                      width: 1.5,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -10,
                        top: -10,
                        child: Icon(
                          item['icon'] as IconData,
                          size: 60.sp,
                          color: (item['color'] as Color).withOpacity(0.05),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                color: (item['color'] as Color).withOpacity(
                                  0.1,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                item['icon'] as IconData,
                                color: item['color'] as Color,
                                size: 22.sp,
                              ),
                            ),
                            SizedBox(width: 14.w),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    title: item['count'].toString(),
                                    textStyle: GoogleFonts.inter(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.w900,
                                      color: AppColors.mainBlack,
                                    ),
                                  ),
                                  CustomText(
                                    title: (item['title'] as String).tr(),
                                    textStyle: GoogleFonts.tajawal(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textGrey,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
                .animate(delay: (index * 150).ms)
                .fadeIn()
                .slideX(begin: 0.2, end: 0);
          }),
        );
      },
    );
  }
}
