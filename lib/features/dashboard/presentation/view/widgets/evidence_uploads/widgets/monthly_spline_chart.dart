import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:qualiverse/features/dashboard/data/models/monthly_chart_data_model.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class MonthlySplineChart extends StatelessWidget {
  final List<MonthlyChartDataModel> data;
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;

  const MonthlySplineChart({
    super.key,
    required this.data,
    required this.fadeAnimation,
    required this.slideAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final isWhite =
        Theme.of(context).scaffoldBackgroundColor == AppColors.white;
    return FadeTransition(
      opacity: fadeAnimation,
      child: SlideTransition(
        position: slideAnimation,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: isWhite ? AppColors.grey : AppColors.mainBlack,
            boxShadow: [
              BoxShadow(
                color: AppColors.mainBlack.withOpacity(0.25),
                offset: const Offset(0, 4),
                blurRadius: 4,
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildSfChart(context, isWhite),
              if (data.isEmpty || data.every((d) => d.value == 0))
                _buildEmptyState(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSfChart(BuildContext context, bool isWhite) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      backgroundColor: isWhite ? AppColors.grey : AppColors.mainBlack,
      plotAreaBackgroundColor: isWhite ? AppColors.grey : AppColors.mainBlack,
      primaryXAxis: CategoryAxis(
        isVisible: true,
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
        majorGridLines: const MajorGridLines(width: 0),
        interval: 1,
        labelIntersectAction: AxisLabelIntersectAction.none,
        labelAlignment: LabelAlignment.center,
        labelStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
          fontSize: 15.sp,
          color: isWhite ? AppColors.textGrey : AppColors.white,
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
          color: Theme.of(context).colorScheme.onSecondary,
          width: 2.5,
          animationDuration: 2000,
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.top,
            textStyle: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(fontSize: 13.sp),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Column(
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
    );
  }
}
