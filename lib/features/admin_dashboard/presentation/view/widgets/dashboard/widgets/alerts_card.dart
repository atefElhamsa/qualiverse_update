import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'common_dashboard_widgets.dart';
import 'dashboard_models.dart';

class DashboardAlertsCard extends StatelessWidget {
  final List<AlertItem> alerts;
  final VoidCallback onViewAll;
  const DashboardAlertsCard({
    super.key,
    required this.alerts,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return BaseDashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: "alerts".tr(),
            textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 16.sp,
              color: AppColors.mainBlack,
            ),
          ),
          SizedBox(height: 12.h),
          Expanded(
            child: ListView.separated(
              itemCount: alerts.length,
              separatorBuilder: (_, __) => SizedBox(height: 8.h),
              itemBuilder: (_, i) {
                final a = alerts[i];
                return Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: a.color.withOpacity(0.06),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: a.color.withOpacity(0.1)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6.w),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Icon(a.icon, color: a.color, size: 16.sp),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: a.title.tr(),
                              textStyle: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.sp,
                                    color: AppColors.mainBlack,
                                  ),
                            ),
                            CustomText(
                              title: a.subtitle.tr(),
                              textStyle: Theme.of(context).textTheme.labelSmall!
                                  .copyWith(
                                    color: AppColors.textGrey.withOpacity(0.7),
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 10.sp,
                        color: AppColors.textGrey.withOpacity(0.5),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 8.h),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          SizedBox(height: 8.h),
          DashboardViewAllRow(onTap: onViewAll, title: "viewAllAlerts"),
        ],
      ),
    );
  }
}
