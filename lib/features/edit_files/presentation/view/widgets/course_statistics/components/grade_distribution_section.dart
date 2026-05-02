import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/features/edit_files/data/models/get_file_data_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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
            "GRADE DISTRIBUTION",
            style: GoogleFonts.cairo(
              fontSize: 18.sp,
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
        labelStyle: GoogleFonts.cairo(
          fontWeight: FontWeight.bold,
          color: const Color(0xFF1A1A1A),
          fontSize: 10.sp,
        ),
      ),
      primaryYAxis: NumericAxis(
        majorGridLines: MajorGridLines(
          width: 1,
          color: Colors.grey.shade100,
          dashArray: const [5, 5],
        ),
        axisLine: const AxisLine(width: 0),
        isVisible: false,
      ),
      series: <CartesianSeries<_GradeData, String>>[
        ColumnSeries<_GradeData, String>(
          animationDuration: 1500,
          dataSource: _getGradeDataList(),
          xValueMapper: (_GradeData g, _) => g.label,
          yValueMapper: (_GradeData g, _) => g.value,
          borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
          width: 0.6,
          spacing: 0.1,
          onCreateRenderer: (ChartSeries<_GradeData, String> series) {
            return _CustomColumnSeriesRenderer();
          },
          dataLabelSettings: _buildDataLabelSettings(),
          pointColorMapper: (_GradeData g, _) => g.color,
        ),
      ],
      annotations: _getChartAnnotations(),
    );
  }

  DataLabelSettings _buildDataLabelSettings() {
    return DataLabelSettings(
      isVisible: true,
      labelAlignment: ChartDataLabelAlignment.outer,
      builder: (data, point, series, pointIndex, seriesIndex) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: const Color(0xFF0F569E),
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Text(
            point.y.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
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
              color: grade.color.withOpacity(0.8),
              size: 18.sp,
            ),
            coordinateUnit: CoordinateUnit.point,
            x: grade.label,
            y: grade.value.toDouble() + 5,
          ),
        );
      }
    }
    return annotations;
  }

  List<_GradeData> _getGradeDataList() {
    return [
      _GradeData("A+", data.gradeAPlus ?? 0, const Color(0xFF0F569E)),
      _GradeData("A", data.gradeA ?? 0, const Color(0xFF4285F4)),
      _GradeData("A-", data.gradeAMinus ?? 0, const Color(0xFF76A9FF)),
      _GradeData("B+", data.gradeBPlus ?? 0, const Color(0xFF1B5E20)),
      _GradeData("B", data.gradeB ?? 0, const Color(0xFF388E3C)),
      _GradeData("B-", data.gradeBMinus ?? 0, const Color(0xFF66BB6A)),
      _GradeData("C+", data.gradeCPlus ?? 0, const Color(0xFFE65100)),
      _GradeData("C", data.gradeC ?? 0, const Color(0xFFF57C00)),
      _GradeData("C-", data.gradeCMinus ?? 0, const Color(0xFFFFB74D)),
      _GradeData("D+", data.gradeDPlus ?? 0, const Color(0xFFC62828)),
      _GradeData("D", data.gradeD ?? 0, const Color(0xFFE53935)),
      _GradeData("D-", data.gradeDMinus ?? 0, const Color(0xFFEF5350)),
      _GradeData("F", data.gradeF ?? 0, const Color(0xFF263238)),
    ];
  }
}

class _GradeData {
  final String label;
  final int value;
  final Color color;
  _GradeData(this.label, this.value, this.color);
}

class _CustomColumnSeriesRenderer
    extends ColumnSeriesRenderer<_GradeData, String> {
  @override
  ColumnSegment<_GradeData, String> createSegment() {
    return _CustomColumnSegment();
  }
}

class _CustomColumnSegment extends ColumnSegment<_GradeData, String> {
  @override
  void onPaint(Canvas canvas) {
    final Rect rect = segmentRect!.outerRect;
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [fillPaint.color, fillPaint.color.withOpacity(0.7)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(rect);

    canvas.drawRRect(segmentRect!, paint);
  }
}
