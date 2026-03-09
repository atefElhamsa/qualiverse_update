import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../routing/all_routes_imports.dart';

class ChartPage extends StatelessWidget {
  const ChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MonthlyChartCubit(),
      child: const AspectRatio(
        aspectRatio: 16 / 4.5,
        child: MonthlyLineChart(),
      ),
    );
  }
}
