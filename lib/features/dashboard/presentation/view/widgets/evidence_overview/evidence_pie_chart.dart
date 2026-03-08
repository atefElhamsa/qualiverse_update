import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../routing/all_routes_imports.dart';

class EvidencePieChart extends StatelessWidget {
  final double size;

  const EvidencePieChart({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EvidenceStatusCubit, EvidenceStatusState>(
      builder: (context, state) {
        final cubit = context.read<EvidenceStatusCubit>();
        final data = cubit.data;
        final total = data.fold<double>(0, (s, d) => s + d.value);
        final baseRadius = size * 0.28;
        final activeRadius = size * 0.34;
        final centerRadius = size * 0.23;
        return PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              enabled: true,
              touchCallback: (event, response) {
                cubit.onSectionTouched(
                  response?.touchedSection?.touchedSectionIndex ?? -1,
                );
              },
            ),
            centerSpaceRadius: centerRadius,
            sectionsSpace: 3,
            sections: List.generate(data.length, (i) {
              final isActive = cubit.activeIndex == i;
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
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(6.r),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.mainBlack.withOpacity(0.15),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: CustomText(
                          title: '1 ($pct%)',
                          textStyle: GoogleFonts.inter(
                            fontSize: 10.sp,
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
      },
    );
  }
}
