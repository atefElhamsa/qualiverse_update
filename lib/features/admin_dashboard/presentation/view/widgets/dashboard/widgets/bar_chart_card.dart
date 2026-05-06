import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'common_dashboard_widgets.dart';

import 'package:qualiverse/features/admin_dashboard/presentation/view/widgets/dashboard/widgets/department_bar_data.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/view/widgets/dashboard/widgets/bar_chart_helper_widgets.dart';

class DashboardBarChartCard extends StatelessWidget {
  final String title;
  final List<DepartmentBarData> data;

  const DashboardBarChartCard({
    super.key,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return BaseDashboardCard(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CustomText(
                    title: "$title (${'programmatic'.tr()})",
                    textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.w800,
                      fontSize: 18.sp,
                      color: AppColors.mainBlack,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.info_outline,
                    size: 16.sp,
                    color: AppColors.textGrey.withOpacity(0.5),
                  ),
                ],
              ),
              Row(
                children: [
                  BarChartLegendItem(
                    label: 'indicators'.tr(),
                    color: AppColors.blue,
                  ),
                  SizedBox(width: 20.w),
                  BarChartLegendItem(
                    label: 'courses'.tr(),
                    color: AppColors.green,
                  ),
                  SizedBox(width: 20.w),
                  BarChartLegendItem(
                    label: 'overall'.tr(),
                    color: AppColors.orange,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 32.h),
          SizedBox(
            height: 350.h,
            child: SfCartesianChart(
              key: ValueKey(data),
              margin: EdgeInsets.zero,
              plotAreaBorderWidth: 0,
              primaryXAxis: CategoryAxis(
                majorGridLines: const MajorGridLines(width: 0),
                axisLine: const AxisLine(width: 1, color: Color(0xFFE2E8F0)),
                labelStyle: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textGrey,
                ),
              ),
              primaryYAxis: NumericAxis(
                minimum: 0,
                maximum: 100,
                interval: 25,
                labelFormat: '{value}%',
                axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(size: 0),
                majorGridLines: MajorGridLines(
                  width: 1,
                  color: Colors.grey.withOpacity(0.1),
                  dashArray: const [5, 5],
                ),
                labelStyle: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textGrey,
                ),
              ),
              series: <CartesianSeries>[
                ColumnSeries<DepartmentBarData, String>(
                  dataSource: data,
                  xValueMapper: (d, _) => d.department,
                  yValueMapper: (d, _) => d.indicators,
                  name: 'indicators'.tr(),
                  color: AppColors.blue,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(4.r),
                  ),
                  spacing: 0.1,
                  width: 0.55,
                  animationDuration: 1500,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.blue,
                    ),
                    labelAlignment: ChartDataLabelAlignment.outer,
                    labelPosition: ChartDataLabelPosition.outside,
                  ),
                ),
                ColumnSeries<DepartmentBarData, String>(
                  dataSource: data,
                  xValueMapper: (d, _) => d.department,
                  yValueMapper: (d, _) => d.courses,
                  name: 'courses'.tr(),
                  color: AppColors.green,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(4.r),
                  ),
                  spacing: 0.1,
                  width: 0.55,
                  animationDuration: 1800,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.green,
                    ),
                    labelAlignment: ChartDataLabelAlignment.outer,
                    labelPosition: ChartDataLabelPosition.outside,
                  ),
                ),
                ColumnSeries<DepartmentBarData, String>(
                  dataSource: data,
                  xValueMapper: (d, _) => d.department,
                  yValueMapper: (d, _) => d.overall,
                  name: 'overall'.tr(),
                  color: AppColors.orange,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(4.r),
                  ),
                  spacing: 0.1,
                  width: 0.55,
                  animationDuration: 2100,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w800,
                      color: AppColors.orange,
                    ),
                    labelAlignment: ChartDataLabelAlignment.outer,
                    labelPosition: ChartDataLabelPosition.outside,
                  ),
                ),
              ],
              tooltipBehavior: TooltipBehavior(
                enable: true,
                shared: true,
                activationMode: ActivationMode.singleTap,
                color: Colors.white,
                elevation: 4,
                builder:
                    (
                      dynamic data,
                      dynamic point,
                      dynamic series,
                      int pointIndex,
                      int seriesIndex,
                    ) {
                      final DepartmentBarData d = data as DepartmentBarData;
                      return Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: d.department,
                              textStyle: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w800,
                                color: AppColors.mainBlack,
                              ),
                            ),
                            SizedBox(height: 10.h),
                            BarChartTooltipItem(
                              label: 'indicators'.tr(),
                              value: d.indicators,
                              detailValue:
                                  "${d.indicatorsCount}/${d.indicatorsTotal}",
                              color: AppColors.blue,
                            ),
                            SizedBox(height: 6.h),
                            BarChartTooltipItem(
                              label: 'courses'.tr(),
                              value: d.courses,
                              detailValue:
                                  "${d.coursesCount}/${d.coursesTotal}",
                              color: AppColors.green,
                            ),
                            SizedBox(height: 6.h),
                            BarChartTooltipItem(
                              label: 'overall'.tr(),
                              value: d.overall,
                              color: AppColors.orange,
                            ),
                          ],
                        ),
                      );
                    },
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline, size: 16.sp, color: AppColors.blue),
              SizedBox(width: 10.w),
              CustomText(
                title: 'overallProgressCalculation'.tr(),
                textStyle: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textGrey.withOpacity(0.6),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
  }
}
