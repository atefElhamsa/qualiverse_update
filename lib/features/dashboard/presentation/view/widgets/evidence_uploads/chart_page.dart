import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_state.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/monthly_chart/monthly_chart_cubit.dart';
import 'package:qualiverse/features/dashboard/data/models/monthly_chart_data_model.dart';
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
