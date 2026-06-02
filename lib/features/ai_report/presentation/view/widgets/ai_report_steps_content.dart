import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/ai_report/presentation/controller/ai_report_cubit.dart';
import 'package:qualiverse/features/ai_report/presentation/controller/ai_report_state.dart';
import 'package:qualiverse/features/ai_report/presentation/view/widgets/ai_report_basic_info_step.dart';
import 'package:qualiverse/features/ai_report/presentation/view/widgets/ai_report_credit_hours_step.dart';
import 'package:qualiverse/features/ai_report/presentation/view/widgets/ai_report_topics_step.dart';
import 'package:qualiverse/features/ai_report/presentation/view/widgets/ai_report_assessments_step.dart';
import 'ai_report_instructors_step.dart';

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
