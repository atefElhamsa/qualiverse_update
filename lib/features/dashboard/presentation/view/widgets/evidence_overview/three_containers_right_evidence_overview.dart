import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_state.dart';
import 'package:qualiverse/features/dashboard/data/models/dashboard_response_model.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class EvidenceSummaryCards extends StatelessWidget {
  const EvidenceSummaryCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        IndicatorOverview? overview;
        if (state is DashboardSuccess) {
          overview = state.data.indicatorOverview;
        }

        final data = [
          {
            "title": "reviewedEvidence",
            "count": overview?.approvedIndicators ?? 0,
            "icon": Icons.check_circle_outline,
            "bgColor": const Color(0xFFE8F5E9),
            "accentColor": Colors.green.shade600,
          },
          {
            "title": "pendingEvidence",
            "count": overview?.pendingIndicators ?? 0,
            "icon": Icons.access_time_rounded,
            "bgColor": const Color(0xFFFFF3E0),
            "accentColor": Colors.orange.shade700,
          },
          {
            "title": "totalEvidence",
            "count": overview?.totalIndicators ?? 0,
            "icon": Icons.folder_open_rounded,
            "bgColor": const Color(0xFFF5F5F5),
            "accentColor": AppColors.mainBlack,
          },
        ];

        return Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(data.length, (index) {
            final item = data[index];
            return Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color:
                    Theme.of(context).scaffoldBackgroundColor == AppColors.white
                    ? AppColors.white
                    : AppColors.mainBlack,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.1),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: (item['accentColor'] as Color).withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: item['bgColor'] as Color,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      item['icon'] as IconData,
                      color: item['accentColor'] as Color,
                      size: 26.sp,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: item["count"].toString(),
                          textStyle: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w800,
                            color: item['accentColor'] as Color,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        CustomText(
                          title: item["title"].toString().tr(),
                          textStyle: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color:
                                Theme.of(context).textTheme.bodyMedium?.color
                                    ?.withOpacity(0.6) ??
                                Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
