import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class EvidenceStatusChart extends StatefulWidget {
  const EvidenceStatusChart({super.key});

  @override
  State<EvidenceStatusChart> createState() => _EvidenceStatusChartState();
}

class _EvidenceStatusChartState extends State<EvidenceStatusChart> {
  int activeIndex = -1;

  final List<ChartDataModel> data = const [
    ChartDataModel(label: 'Reviewed', value: 1, color: AppColors.reviewedColor),
    ChartDataModel(label: 'Approved', value: 1, color: AppColors.approvedColor),
    ChartDataModel(label: 'Rejected', value: 1, color: AppColors.rejectedColor),
    ChartDataModel(label: 'Pending', value: 1, color: AppColors.pendingColor),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 599),
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
          buildLayoutBuilder(),
        ],
      ),
    );
  }

  LayoutBuilder buildLayoutBuilder() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 420;
        // chart size followed container size
        final chartSize = (constraints.maxWidth * 0.45).clamp(120.0, 240.0);
        if (isNarrow) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: chartSize,
                height: chartSize,
                child: buildPieChart(chartSize),
              ),
              const SizedBox(height: 16),
              buildLegend(),
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
                child: buildPieChart(chartSize),
              ),
            ),
            const SizedBox(width: 24),
            buildLegend(),
          ],
        );
      },
    );
  }

  Widget buildPieChart(double size) {
    final total = data.fold<double>(0, (s, d) => s + d.value);
    final baseRadius = size * 0.28;
    final activeRadius = size * 0.34;
    final centerRadius = size * 0.23;

    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          enabled: true,
          touchCallback: (event, response) {
            setState(() {
              activeIndex = response?.touchedSection?.touchedSectionIndex ?? -1;
            });
          },
        ),
        centerSpaceRadius: centerRadius,
        sectionsSpace: 3,
        sections: List.generate(data.length, (i) {
          final isActive = activeIndex == i;
          final pct = (data[i].value / total * 100).toStringAsFixed(2);
          return PieChartSectionData(
            value: data[i].value,
            color: data[i].color,
            radius: isActive ? activeRadius : baseRadius,
            showTitle: false,
            badgeWidget: isActive
                ? Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: Text(
                      '1 ($pct%)',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: data[i].color,
                      ),
                    ),
                  )
                : null,
            badgePositionPercentageOffset: 1.5,
          );
        }),
      ),
      swapAnimationDuration: const Duration(milliseconds: 300),
      swapAnimationCurve: Curves.easeOutCubic,
    );
  }

  Widget buildLegend() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Status',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF666666),
          ),
        ),
        const SizedBox(height: 8),
        ...List.generate(data.length, (i) {
          final isActive = activeIndex == i;
          return GestureDetector(
            onTap: () => setState(() => activeIndex = isActive ? -1 : i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: isActive
                    ? data[i].color.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isActive ? data[i].color : Colors.transparent,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: isActive ? 14 : 11,
                    height: isActive ? 14 : 11,
                    decoration: BoxDecoration(
                      color: data[i].color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    data[i].label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                      color: isActive ? data[i].color : const Color(0xFF444444),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
