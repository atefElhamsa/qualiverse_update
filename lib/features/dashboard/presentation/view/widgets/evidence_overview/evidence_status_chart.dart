import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'evidence_pie_chart.dart';
import 'evidence_legend.dart';
import 'package:easy_localization/easy_localization.dart';

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
      constraints: const BoxConstraints(maxWidth: 640),
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
            title: 'evidenceStatusDistribution'.tr(),
            textStyle: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(fontSize: 13.sp),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 420;
              final chartSize = (constraints.maxWidth * 0.48).clamp(
                150.0,
                260.0,
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
