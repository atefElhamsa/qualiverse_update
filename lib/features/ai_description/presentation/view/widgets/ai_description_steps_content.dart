import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

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
          case 5:
            return const DownloadFilesStep();
          default:
            return const SizedBox();
        }
      },
    );
  }
}
