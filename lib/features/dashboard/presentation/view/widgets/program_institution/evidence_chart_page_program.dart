import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_state.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/evidence/evidence_cubit.dart';
import 'package:qualiverse/features/dashboard/data/models/evidence_data_model.dart';
import 'package:qualiverse/features/dashboard/presentation/view/widgets/program_institution/evidence_legend_program.dart';
import 'package:qualiverse/features/dashboard/presentation/view/widgets/program_institution/evidence_chart_program.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class EvidenceChartPageProgram extends StatelessWidget {
  const EvidenceChartPageProgram({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EvidenceLegendProgram(),
        SizedBox(height: 12),
        AspectRatio(aspectRatio: 16 / 5, child: EvidenceChartProgram()),
      ],
    );
  }
}
