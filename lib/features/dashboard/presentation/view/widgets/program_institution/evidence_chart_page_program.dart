import 'package:flutter/material.dart';
import 'package:qualiverse/features/dashboard/presentation/view/widgets/program_institution/evidence_legend_program.dart';
import 'package:qualiverse/features/dashboard/presentation/view/widgets/program_institution/evidence_chart_program.dart';

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
