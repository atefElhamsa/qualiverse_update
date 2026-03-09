import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../routing/all_routes_imports.dart';

class EvidenceChartProgram extends StatelessWidget {
  const EvidenceChartProgram({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EvidenceCubit, EvidenceState>(
      builder: (context, state) {
        if (state is! EvidenceLoaded) return const SizedBox.shrink();
        return Container(
          decoration: BoxDecoration(
            color: AppColors.grey,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                offset: const Offset(0, 4),
                spreadRadius: 0,
                blurRadius: 4,
              ),
            ],
          ),
          padding: const EdgeInsets.all(16),
          child: SfCartesianChart(
            title: ChartTitle(
              text: 'Evidence Per Criterion',
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontSize: 16.sp),
            ),
            plotAreaBorderWidth: 0,
            backgroundColor: AppColors.grey,
            primaryXAxis: CategoryAxis(
              title: AxisTitle(
                text: 'Criterion Name',
                textStyle: Theme.of(
                  context,
                ).textTheme.headlineLarge!.copyWith(fontSize: 16.sp),
              ),
              majorGridLines: const MajorGridLines(width: 0),
              axisLine: const AxisLine(width: 0),
              majorTickLines: const MajorTickLines(size: 0),
              labelStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 16.sp,
                color: AppColors.textGrey,
              ),
            ),
            primaryYAxis: const NumericAxis(
              isVisible: false,
              majorGridLines: MajorGridLines(width: 0),
              axisLine: AxisLine(width: 0),
            ),
            series: buildSeries(state),
            enableAxisAnimation: true,
            legend: const Legend(isVisible: false),
            tooltipBehavior: TooltipBehavior(enable: true),
            annotations: buildAnnotations(state, context),
          ),
        );
      },
    );
  }

  List<StackedBarSeries<EvidenceDataModel, String>> buildSeries(
    EvidenceLoaded state,
  ) {
    final series = <StackedBarSeries<EvidenceDataModel, String>>[];

    const labelSettings = DataLabelSettings(
      isVisible: true,
      labelAlignment: ChartDataLabelAlignment.middle,
      textStyle: TextStyle(
        color: AppColors.mainBlack,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );

    if (state.showPending) {
      series.add(
        StackedBarSeries<EvidenceDataModel, String>(
          name: 'Pending Evidence',
          dataSource: state.data,
          xValueMapper: (d, _) => d.criterion,
          yValueMapper: (d, _) => d.pending,
          color: AppColors.evidenceColorSlide2,
          dataLabelSettings: labelSettings,
        ),
      );
    }

    if (state.showReviewed) {
      series.add(
        StackedBarSeries<EvidenceDataModel, String>(
          name: 'Reviewed Evidence',
          dataSource: state.data,
          xValueMapper: (d, _) => d.criterion,
          yValueMapper: (d, _) => d.reviewed,
          color: AppColors.evidenceColorSlide3,
          dataLabelSettings: labelSettings,
        ),
      );
    }

    if (state.showRejected) {
      series.add(
        StackedBarSeries<EvidenceDataModel, String>(
          name: 'Rejected Evidence',
          dataSource: state.data,
          xValueMapper: (d, _) => d.criterion,
          yValueMapper: (d, _) => d.rejected,
          color: AppColors.evidenceColorSlide4,
          dataLabelSettings: labelSettings,
        ),
      );
    }

    return series;
  }

  List<CartesianChartAnnotation> buildAnnotations(
    EvidenceLoaded state,
    context,
  ) {
    return state.data.map((d) {
      int total = 0;
      if (state.showPending) total += d.pending;
      if (state.showReviewed) total += d.reviewed;
      if (state.showRejected) total += d.rejected;

      return CartesianChartAnnotation(
        widget: CustomText(
          title: '$total',
          textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontSize: 16.sp,
            color: AppColors.textGrey,
          ),
        ),
        coordinateUnit: CoordinateUnit.point,
        x: d.criterion,
        y: total + (total * 0.05),
      );
    }).toList();
  }
}
