import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/monthly_chart/monthly_chart_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/monthly_chart/monthly_chart_state.dart';
import 'package:qualiverse/features/dashboard/data/models/monthly_chart_data_model.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:easy_localization/easy_localization.dart';

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
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
                ? AppColors.white
                : AppColors.mainBlack,
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: Colors.grey.withOpacity(0.1), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                offset: const Offset(0, 10),
                blurRadius: 30,
                spreadRadius: 0,
              ),
            ],
          ),
          padding: EdgeInsets.only(
            top: 24.h,
            bottom: 8.h,
            left: 16.w,
            right: 16.w,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SfCartesianChart(
                plotAreaBorderWidth: 0,
                backgroundColor: Colors.transparent,
                plotAreaBackgroundColor: Colors.transparent,
                primaryXAxis: CategoryAxis(
                  isVisible: true,
                  axisLine: const AxisLine(width: 0),
                  majorTickLines: const MajorTickLines(size: 0),
                  majorGridLines: const MajorGridLines(width: 0),
                  interval: 1,
                  maximumLabels: 12,
                  labelIntersectAction: AxisLabelIntersectAction.none,
                  labelAlignment: LabelAlignment.center,
                  labelStyle: Theme.of(context).textTheme.headlineLarge!
                      .copyWith(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color:
                            Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color?.withOpacity(0.6) ??
                            Colors.grey.shade600,
                      ),
                ),
                primaryYAxis: const NumericAxis(
                  isVisible: false,
                  rangePadding: ChartRangePadding.additional,
                ),
                series: <CartesianSeries>[
                  SplineAreaSeries<MonthlyChartDataModel, String>(
                    dataSource: data,
                    xValueMapper: (d, _) => d.month.toLowerCase().tr(),
                    yValueMapper: (d, _) => d.value,
                    splineType: SplineType.natural,
                    gradient: LinearGradient(
                      colors: [
                        AppColors.viewAndDeleteIconColor.withOpacity(0.5),
                        AppColors.viewAndDeleteIconColor.withOpacity(0.0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderColor: AppColors.viewAndDeleteIconColor,
                    borderWidth: 3.5,
                    animationDuration: 2000,
                    dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      labelAlignment: ChartDataLabelAlignment.top,
                      textStyle: Theme.of(context).textTheme.headlineLarge!
                          .copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.viewAndDeleteIconColor,
                          ),
                    ),
                    markerSettings: const MarkerSettings(
                      isVisible: true,
                      height: 8,
                      width: 8,
                      color: AppColors.white,
                      borderWidth: 2,
                      borderColor: AppColors.viewAndDeleteIconColor,
                    ),
                  ),
                ],
              ),
              if (data.isEmpty || data.every((d) => d.value == 0))
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      title: '0'.tr(),
                      textStyle: GoogleFonts.inter(
                        fontSize: 40.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textGrey.withOpacity(0.3),
                      ),
                    ),
                    CustomText(
                      title: 'totalUploads'.tr(),
                      textStyle: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textGrey.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
