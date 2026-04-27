import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/dashboard/data/models/chart_data_model.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_state.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/evidence_status/evidence_status_cubit.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'evidence_pie_chart.dart';
import 'evidence_legend.dart';

class EvidenceStatusChart extends StatelessWidget {
  const EvidenceStatusChart({super.key});

  @override
  Widget build(BuildContext context) {
    return const EvidenceStatusChartView();
  }
}

class EvidenceStatusChartView extends StatelessWidget {
  const EvidenceStatusChartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 599),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
            ? AppColors.grey
            : AppColors.mainBlack,
        boxShadow: [
          BoxShadow(
            color: AppColors.mainBlack.withOpacity(0.25),
            offset: const Offset(0, 4),
            spreadRadius: 0,
            blurRadius: 4,
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            title: 'Evidence Status Distribution',
            textStyle: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(fontSize: 16.sp),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 420;
              final chartSize = (constraints.maxWidth * 0.45).clamp(
                120.0,
                240.0,
              );
              if (isNarrow) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: chartSize,
                      height: chartSize,
                      child: EvidencePieChart(size: chartSize),
                    ),
                    const SizedBox(height: 16),
                    const EvidenceLegend(),
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      width: chartSize,
                      height: chartSize,
                      child: EvidencePieChart(size: chartSize),
                    ),
                  ),
                  const SizedBox(width: 24),
                  const EvidenceLegend(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
