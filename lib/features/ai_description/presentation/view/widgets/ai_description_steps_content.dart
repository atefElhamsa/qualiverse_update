import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/ai_description/presentation/controller/ai_description_cubit.dart';
import 'basic_info_step.dart';
import 'facilities_step.dart';
import 'learning_hours_step.dart';
import 'resources_step.dart';
import 'schedule_step.dart';

class AiDescriptionStepsContent extends StatelessWidget {
  const AiDescriptionStepsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiDescriptionCubit, AiDescriptionState>(
      buildWhen: (previous, current) => current is AiDescriptionPageChanged,
      builder: (context, state) {
        final currentPage = context.read<AiDescriptionCubit>().currentPage;
        switch (currentPage) {
          case 0:
            return const BasicInfoStep();
          case 1:
            return const ScheduleStep();
          case 2:
            return const LearningHoursStep();
          case 3:
            return const ResourcesStep();
          case 4:
            return const FacilitiesStep();
          default:
            return const SizedBox();
        }
      },
    );
  }
}
