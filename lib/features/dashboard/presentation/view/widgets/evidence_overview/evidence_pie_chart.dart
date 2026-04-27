import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/evidence_status/evidence_status_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/evidence_status/evidence_status_state.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

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

        List<PieChartSectionData> sections = [];
        if (total == 0) {
          sections = [
            PieChartSectionData(
              value: 1,
              color: AppColors.grey.withOpacity(0.5),
              radius: baseRadius,
              showTitle: false,
            )
          ];
        } else {
          sections = List.generate(data.length, (i) {
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
                        title: '${data[i].value.toInt()} ($pct%)',
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
          });
        }

        return Stack(
          alignment: Alignment.center,
          children: [
            PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  enabled: total > 0,
                  touchCallback: (event, response) {
                    if (total > 0) {
                      cubit.onSectionTouched(
                        response?.touchedSection?.touchedSectionIndex ?? -1,
                      );
                    }
                  },
                ),
                centerSpaceRadius: centerRadius,
                sectionsSpace: total > 0 ? 3 : 0,
                sections: sections,
              ),
              swapAnimationDuration: const Duration(milliseconds: 300),
              swapAnimationCurve: Curves.easeOutCubic,
            ),
            if (total == 0)
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    title: '0',
                    textStyle: GoogleFonts.inter(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textGrey.withOpacity(0.5),
                    ),
                  ),
                  CustomText(
                    title: 'Total Indicators',
                    textStyle: GoogleFonts.inter(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textGrey.withOpacity(0.4),
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}
