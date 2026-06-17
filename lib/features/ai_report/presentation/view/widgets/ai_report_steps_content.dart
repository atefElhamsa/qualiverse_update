import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AiReportStepsContent extends StatelessWidget {
  const AiReportStepsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiReportCubit, AiReportState>(
      buildWhen: (previous, current) => current is AiReportPageChanged,
      builder: (context, state) {
        final currentPage = context.read<AiReportCubit>().currentPage;
        switch (currentPage) {
          case 0:
            return const AiReportBasicInfoStep();
          case 1:
            return const AiReportCreditHoursStep();
          case 2:
            return const AiReportInstructorsStep();
          case 3:
            return const AiReportTopicsStep();
          case 4:
            return const AiReportAssessmentsStep();
          default:
            return const SizedBox();
        }
      },
    );
  }
}
