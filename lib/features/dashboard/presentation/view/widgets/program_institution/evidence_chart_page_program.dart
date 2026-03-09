import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../routing/all_routes_imports.dart';

class EvidenceChartPageProgram extends StatelessWidget {
  const EvidenceChartPageProgram({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EvidenceCubit(),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EvidenceLegendProgram(),
          SizedBox(height: 12),
          AspectRatio(aspectRatio: 16 / 5, child: EvidenceChartProgram()),
        ],
      ),
    );
  }
}
