import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'common_dashboard_widgets.dart';
import 'dashboard_models.dart';

class DashboardDonutChartCard extends StatelessWidget {
  final String title, totalLabel, totalValue;
  final List<ChartData> data;
  final List<LegendItem> legends;
  final VoidCallback onViewAll;

  const DashboardDonutChartCard({
    super.key,
    required this.title,
    required this.data,
    required this.totalLabel,
    required this.totalValue,
    required this.legends,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return BaseDashboardCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: title.tr(),
            textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 13.sp,
              color: AppColors.mainBlack,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                flex: 5,
                child: SizedBox(
                  height: 180.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SfCircularChart(
                        margin: EdgeInsets.zero,
                        series: <CircularSeries>[
                          DoughnutSeries<ChartData, String>(
                            dataSource: data,
                            xValueMapper: (d, _) => d.label,
                            yValueMapper: (d, _) => d.value,
                            pointColorMapper: (d, _) => d.color,
                            innerRadius: '75%',
                            radius: '100%',
                            animationDuration: 1500,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            title: totalValue,
                            textStyle: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 28.sp,
                                  color: AppColors.mainBlack,
                                  letterSpacing: -1,
                                ),
                          ),
                          CustomText(
                            title: totalLabel.tr(),
                            textStyle: Theme.of(context).textTheme.labelSmall!
                                .copyWith(
                                  color: AppColors.textGrey,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: legends
                      .asMap()
                      .entries
                      .map((e) => _buildLegend(context, e.value, e.key))
                      .toList(),
                ),
              ),
            ],
          ),
          const Spacer(),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          SizedBox(height: 8.h),
          DashboardViewAllRow(onTap: onViewAll),
        ],
      ),
    );
  }

  Widget _buildLegend(BuildContext context, LegendItem l, int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child:
          Row(
                children: [
                  Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: l.color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: l.title.tr(),
                          textStyle: Theme.of(context).textTheme.bodySmall!
                              .copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 13.sp,
                                color: AppColors.mainBlack,
                              ),
                        ),
                        CustomText(
                          title: l.subtitle.tr(),
                          textStyle: Theme.of(context).textTheme.labelSmall!
                              .copyWith(
                                color: AppColors.textGrey.withOpacity(0.6),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                  CustomText(
                    title: l.value,
                    textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w800,
                      color: l.color,
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              )
              .animate()
              .fadeIn(delay: (200 * index).ms, duration: 400.ms)
              .slideX(begin: 0.1, end: 0),
    );
  }
}
