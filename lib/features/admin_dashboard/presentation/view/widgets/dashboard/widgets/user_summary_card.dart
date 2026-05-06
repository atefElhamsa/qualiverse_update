import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'common_dashboard_widgets.dart';
import 'dashboard_models.dart';

class DashboardUserSummaryCard extends StatelessWidget {
  final List<UserSummaryItem> items;
  final VoidCallback onViewAll;
  const DashboardUserSummaryCard({super.key, required this.items, required this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return BaseDashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(title: "usersSummary".tr(), textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w800, fontSize: 16.sp, color: AppColors.mainBlack)),
          SizedBox(height: 16.h),
          Expanded(
            child: Row(
              children: items.map((item) => Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                  decoration: BoxDecoration(color: item.color.withOpacity(0.05), borderRadius: BorderRadius.circular(12.r), border: Border.all(color: item.color.withOpacity(0.08))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(padding: EdgeInsets.all(6.w), decoration: BoxDecoration(color: AppColors.white, shape: BoxShape.circle), child: Icon(item.icon, color: item.color, size: 18.sp)),
                      SizedBox(height: 6.h),
                      CustomText(title: item.title.tr(), textStyle: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColors.textGrey, fontWeight: FontWeight.w600, fontSize: 12.sp)),
                      FittedBox(child: CustomText(title: item.value, textStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.w800, color: AppColors.mainBlack, fontSize: 20.sp))),
                      CustomText(title: item.subtitle.tr(), textStyle: Theme.of(context).textTheme.labelSmall!.copyWith(color: AppColors.textGrey.withOpacity(0.5), fontSize: 10.sp, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              )).toList(),
            ),
          ),
          SizedBox(height: 8.h),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          SizedBox(height: 8.h),
          DashboardViewAllRow(onTap: onViewAll, title: "viewAllUsers"),
        ],
      ),
    );
  }
}
