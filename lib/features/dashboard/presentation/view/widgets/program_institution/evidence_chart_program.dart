import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/evidence/evidence_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/evidence/evidence_state.dart';
import 'package:qualiverse/features/dashboard/data/models/evidence_data_model.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class EvidenceChartProgram extends StatelessWidget {
  const EvidenceChartProgram({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EvidenceCubit, EvidenceState>(
      builder: (context, state) {
        if (state is! EvidenceLoaded) return const SizedBox.shrink();
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
                ? AppColors.grey
                : AppColors.mainBlack,
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
              text: 'evidencePerCriterion'.tr(),
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontSize: 16.sp),
            ),
            plotAreaBorderWidth: 0,
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor == AppColors.white
                ? AppColors.grey
                : AppColors.mainBlack,
            primaryXAxis: CategoryAxis(
              title: AxisTitle(
                text: 'criterionName'.tr(),
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
              rangePadding: ChartRangePadding.additional,
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

    if (state.showPending) {
      series.add(
        StackedBarSeries<EvidenceDataModel, String>(
          name: 'pendingEvidence'.tr(),
          dataSource: state.data,
          xValueMapper: (d, _) => d.criterion,
          yValueMapper: (d, _) => d.pending,
          color: AppColors.evidenceColorSlide2,
        ),
      );
    }

    if (state.showReviewed) {
      series.add(
        StackedBarSeries<EvidenceDataModel, String>(
          name: 'reviewedEvidence'.tr(),
          dataSource: state.data,
          xValueMapper: (d, _) => d.criterion,
          yValueMapper: (d, _) => d.reviewed,
          color: AppColors.evidenceColorSlide3,
        ),
      );
    }

    if (state.showRejected) {
      series.add(
        StackedBarSeries<EvidenceDataModel, String>(
          name: 'rejectedEvidence'.tr(),
          dataSource: state.data,
          xValueMapper: (d, _) => d.criterion,
          yValueMapper: (d, _) => d.rejected,
          color: AppColors.evidenceColorSlide4,
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
