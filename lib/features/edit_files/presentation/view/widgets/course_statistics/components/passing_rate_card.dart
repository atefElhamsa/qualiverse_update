import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'base_card.dart';

class PassingRateCard extends StatelessWidget {
  final String passPercentage;
  final int passedCount;
  final int totalCount;

  const PassingRateCard({
    super.key,
    required this.passPercentage,
    required this.passedCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    final double percentage =
        double.tryParse(passPercentage.replaceAll('%', '')) ?? 0.0;

    return BaseCard(
      title: "passingRate".tr(),
      child: Column(
        children: [
          SizedBox(
            height: 100.h,
            child: SfRadialGauge(
              enableLoadingAnimation: true,
              animationDuration: 1500,
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 100,
                  showLabels: false,
                  showTicks: false,
                  startAngle: 180,
                  endAngle: 0,
                  radiusFactor: 1.1,
                  canScaleToFit: true,
                  axisLineStyle: const AxisLineStyle(
                    thickness: 12,
                    color: Color(0xFFF1F5F9),
                  ),
                  pointers: <GaugePointer>[
                    RangePointer(
                      value: percentage,
                      width: 12,
                      cornerStyle: CornerStyle.bothCurve,
                      gradient: const SweepGradient(
                        colors: <Color>[Color(0xFF4285F4), Color(0xFF34A853)],
                        stops: <double>[0.25, 0.75],
                      ),
                    ),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Text(
                        "${percentage.toInt()}%",
                        style: GoogleFonts.almarai(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F569E),
                        ),
                      ),
                      angle: 90,
                      positionFactor: 0.1,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            "$passedCount/$totalCount ${"studentsPassed".tr()}",
            style: GoogleFonts.almarai(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
