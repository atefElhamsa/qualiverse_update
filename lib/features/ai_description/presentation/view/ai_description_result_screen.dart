import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/home/presentation/view/widgets/main_wrapper.dart';

import '../controller/ai_description_cubit.dart';
import 'widgets/ai_description_navigation_row.dart';
import 'widgets/ai_description_steps_content.dart';
import 'widgets/ai_description_top.dart';
import 'widgets/ai_step_indicator.dart';

class AiDescriptionResultScreen extends StatelessWidget {
  const AiDescriptionResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AiDescriptionCubit(),
      child: const _AiDescriptionResultContent(),
    );
  }
}

class _AiDescriptionResultContent extends StatelessWidget {
  const _AiDescriptionResultContent();

  @override
  Widget build(BuildContext context) {
    return MainWrapper(
      child: CustomScaffold(
        widget: BlocBuilder<AiDescriptionCubit, AiDescriptionState>(
          buildWhen: (previous, current) => current is AiDescriptionPageChanged,
          builder: (context, state) {
            final cubit = context.read<AiDescriptionCubit>();
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const AiDescriptionTop(),
                  AiStepIndicator(
                    currentPage: cubit.currentPage,
                    totalSteps: 5,
                  ),
                  const AiDescriptionStepsContent(),
                  SizedBox(height: 25.h),
                  const AiDescriptionNavigationRow(),
                  const SizedBox(height: 25),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
