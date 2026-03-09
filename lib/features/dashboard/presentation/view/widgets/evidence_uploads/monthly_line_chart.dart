import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../routing/all_routes_imports.dart';

class MonthlyLineChart extends StatefulWidget {
  const MonthlyLineChart({super.key});

  @override
  State<MonthlyLineChart> createState() => _MonthlyLineChartState();
}

class _MonthlyLineChartState extends State<MonthlyLineChart>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    fadeAnimation = CurvedAnimation(
      parent: controller,
      curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
    );
    slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.7, curve: Curves.easeOutCubic),
          ),
        );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.forward();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MonthlyChartCubit, MonthlyChartState>(
      builder: (context, state) {
        if (state is MonthlyChartLoading) {
          return const CustomLoading();
        }
        if (state is MonthlyChartError) {
          return Center(
            child: CustomText(
              title: state.message,
              textStyle: Theme.of(context).textTheme.bodyMedium!,
            ),
          );
        }
        if (state is MonthlyChartLoaded) {
          return buildChart(state.data);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget buildChart(List<MonthlyChartDataModel> data) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.grey,
              boxShadow: [
                BoxShadow(
                  color: AppColors.mainBlack.withOpacity(0.25),
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                  blurRadius: 4,
                ),
              ],
            ),
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              backgroundColor: AppColors.grey,
              plotAreaBackgroundColor: AppColors.grey,
              primaryXAxis: CategoryAxis(
                isVisible: true,
                axisLine: const AxisLine(width: 0),
                majorTickLines: const MajorTickLines(size: 0),
                majorGridLines: const MajorGridLines(width: 0),
                interval: 1,
                maximumLabels: 12,
                labelIntersectAction: AxisLabelIntersectAction.none,
                labelAlignment: LabelAlignment.center,
                labelStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.textGrey,
                ),
              ),
              primaryYAxis: const NumericAxis(
                isVisible: false,
                rangePadding: ChartRangePadding.additional,
              ),
              series: <CartesianSeries>[
                SplineSeries<MonthlyChartDataModel, String>(
                  dataSource: data,
                  xValueMapper: (d, _) => d.month,
                  yValueMapper: (d, _) => d.value,
                  splineType: SplineType.natural,
                  color: Colors.black,
                  width: 2.5,
                  animationDuration: 2000,
                  dataLabelSettings: DataLabelSettings(
                    isVisible: true,
                    labelAlignment: ChartDataLabelAlignment.top,
                    textStyle: Theme.of(
                      context,
                    ).textTheme.headlineLarge!.copyWith(fontSize: 16.sp),
                  ),
                  markerSettings: const MarkerSettings(isVisible: false),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
