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
      constraints: const BoxConstraints(maxWidth: 640, minHeight: 300),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            title: 'evidenceStatusDistribution'.tr(),
            textStyle: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(fontSize: 14.sp),
          ),
          const SizedBox(height: 15),
          Builder(
            builder: (context) {
              final screenWidth = MediaQuery.of(context).size.width;
              final availableWidth =
                  (screenWidth - 80.w) *
                  (10 / 23); // Approximate width based on flex values
              final isNarrow = availableWidth < 420;
              final chartSize = (availableWidth * 0.48).clamp(150.0, 270.0);
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
