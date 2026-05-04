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
            "color": const Color(0xFFE8F5E9),
            "textColor": Colors.green.shade700,
          },
          {
            "title": "pendingEvidence",
            "count": overview?.pendingIndicators ?? 0,
            "color": const Color(0xFFFFF3E0),
            "textColor": Colors.orange.shade800,
          },
          {
            "title": "totalEvidence",
            "count": overview?.totalIndicators ?? 0,
            "color": const Color(0xFFF5F5F5),
            "textColor": AppColors.mainBlack,
          },
        ];

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(data.length, (index) {
            final item = data[index];
            return Container(
              width: 220.w,
              margin: EdgeInsets.only(bottom: index == 2 ? 0 : 20.h),
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
              decoration: BoxDecoration(
                color: item['color'] as Color,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  CustomText(
                    title: item["title"].toString().tr(),
                    textStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: (item['textColor'] as Color).withOpacity(0.8),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomText(
                    title: item["count"].toString(),
                    textStyle: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w800,
                      color: item['textColor'] as Color,
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
