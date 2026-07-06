import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class GradeDistributionSection extends StatelessWidget {
  final GetFileDataModel data;
  const GradeDistributionSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            "gradeDistribution".tr(),
            style: GoogleFonts.almarai(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1A1A),
            ),
          ),
        ),
        SizedBox(height: 20.h),
        Container(
          height: 400.h,
          decoration: _buildChartDecoration(),
          padding: EdgeInsets.all(20.w),
          child: _buildChart(),
        ),
      ],
    );
  }

  BoxDecoration _buildChartDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(25.r),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF0F569E).withOpacity(0.05),
          blurRadius: 30,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  Widget _buildChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: CategoryAxis(
        majorGridLines: const MajorGridLines(width: 0),
        axisLine: const AxisLine(width: 0),
        labelStyle: GoogleFonts.almarai(
          fontWeight: FontWeight.bold,
          color: const Color(0xFF757575),
          fontSize: 10.sp,
        ),
      ),
      primaryYAxis: const NumericAxis(
        majorGridLines: MajorGridLines(width: 0),
        axisLine: AxisLine(width: 0),
        isVisible: false,
        minimum: -1,
      ),
      series: <CartesianSeries<_GradeData, String>>[
        SplineSeries<_GradeData, String>(
          animationDuration: 1500,
          dataSource: _getGradeDataList(),
          xValueMapper: (_GradeData g, _) => g.label,
          yValueMapper: (_GradeData g, _) => g.value,
          color: const Color(0xFF2196F3),
          width: 3,
          markerSettings: MarkerSettings(
            isVisible: true,
            shape: DataMarkerType.circle,
            color: Colors.white,
            borderWidth: 2,
            borderColor: const Color(0xFF2196F3),
            width: 8.w,
            height: 8.w,
          ),
          dataLabelSettings: DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.top,
            textStyle: GoogleFonts.almarai(
              color: const Color(0xFF2196F3),
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
      annotations: _getChartAnnotations(),
    );
  }

  List<CartesianChartAnnotation> _getChartAnnotations() {
    final List<_GradeData> dataPoints = _getGradeDataList();
    final List<CartesianChartAnnotation> annotations = [];

    final specialGrades = {
      "A+": Icons.stars_rounded,
      "B+": Icons.lightbulb_rounded,
      "C+": Icons.emoji_events_rounded,
    };

    for (var grade in dataPoints) {
      if (specialGrades.containsKey(grade.label) && grade.value > 0) {
        annotations.add(
          CartesianChartAnnotation(
            widget: Icon(
              specialGrades[grade.label],
              color: const Color(0xFF2196F3).withOpacity(0.8),
              size: 15.sp,
            ),
            coordinateUnit: CoordinateUnit.point,
            x: grade.label,
            y: grade.value.toDouble() + 3,
          ),
        );
      }
    }
    return annotations;
  }

  List<_GradeData> _getGradeDataList() {
    return [
      _GradeData("A+", data.gradeAPlus ?? 0),
      _GradeData("A", data.gradeA ?? 0),
      _GradeData("A-", data.gradeAMinus ?? 0),
      _GradeData("B+", data.gradeBPlus ?? 0),
      _GradeData("B", data.gradeB ?? 0),
      _GradeData("B-", data.gradeBMinus ?? 0),
      _GradeData("C+", data.gradeCPlus ?? 0),
      _GradeData("C", data.gradeC ?? 0),
      _GradeData("C-", data.gradeCMinus ?? 0),
      _GradeData("D+", data.gradeDPlus ?? 0),
      _GradeData("D", data.gradeD ?? 0),
      _GradeData("D-", data.gradeDMinus ?? 0),
      _GradeData("F", data.gradeF ?? 0),
    ];
  }
}

class _GradeData {
  final String label;
  final int value;
  _GradeData(this.label, this.value);
}
