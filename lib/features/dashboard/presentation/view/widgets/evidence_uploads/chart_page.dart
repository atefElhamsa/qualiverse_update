import 'package:flutter/material.dart';
import 'monthly_line_chart.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const AspectRatio(
      aspectRatio: 16 / 4.5,
      child: MonthlyLineChart(),
    );
  }
}
