import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CompletionChart extends StatefulWidget {
  const CompletionChart({super.key});

  @override
  State<CompletionChart> createState() => _CompletionChartState();
}

class _CompletionChartState extends State<CompletionChart> {
  final List<BarChartData> data = [
    BarChartData('informationSystems', 50),
    BarChartData('informationTechnology', 65),
    BarChartData('computerScience', 70),
    BarChartData('artificialIntelligence', 80),
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsetsDirectional.only(
          start: 30.w,
          end: 30.w,
          bottom: 20.h,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.mainBlack.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: SfCartesianChart(
          plotAreaBackgroundColor: AppColors.plotAreaBackgroundColor,
          plotAreaBorderWidth: 1,
          plotAreaBorderColor: AppColors.plotAreaBorderColor,
          title: ChartTitle(
            text: 'completionChart'.tr(),
            textStyle: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontSize: 18.sp),
          ),
          primaryXAxis: CategoryAxis(
            majorGridLines: const MajorGridLines(width: 0),
            axisLine: const AxisLine(width: 0),
            labelStyle: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontSize: 16.sp),
          ),
          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: 100,
            interval: 10,
            majorGridLines: const MajorGridLines(
              width: 1,
              color: AppColors.plotAreaBorderColor,
            ),
            minorGridLines: const MinorGridLines(
              width: 0.5,
              color: AppColors.minorGridLines,
            ),
            minorTicksPerInterval: 1,
            axisLine: const AxisLine(width: 0),
            labelStyle: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontSize: 13.sp),
          ),
          // plotAreaBorderWidth: 1,
          tooltipBehavior: TooltipBehavior(
            enable: true,
            color: AppColors.tooltipBehavior,
            textStyle: const TextStyle(color: AppColors.white),
            format: 'point.x : point.y%',
          ),
          series: <CartesianSeries>[
            ColumnSeries<BarChartData, String>(
              dataSource: data,
              xValueMapper: (BarChartData d, _) => d.label.tr(),
              yValueMapper: (BarChartData d, _) => d.value,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(6),
              ),
              gradient: const LinearGradient(
                colors: [AppColors.tooltipBehavior, AppColors.gradiant],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              animationDuration: 1200,
              dataLabelSettings: const DataLabelSettings(
                isVisible: true,
                labelAlignment: ChartDataLabelAlignment.top,
                textStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BarChartData {
  final String label;
  final double value;

  BarChartData(this.label, this.value);
}
