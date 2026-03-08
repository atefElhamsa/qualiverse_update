import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class EvidencePerCriterionView extends StatelessWidget {
  const EvidencePerCriterionView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EvidencePerCriterionCubit, EvidencePerCriterionState>(
      builder: (context, state) {
        if (state is! EvidencePerCriterionLoaded) {
          return const SizedBox.shrink();
        }
        final data = state.data;
        final maxValue = data
            .map((d) => d.value)
            .reduce((a, b) => a > b ? a : b);
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.grey,
            boxShadow: [
              BoxShadow(
                color: AppColors.mainBlack.withOpacity(0.25),
                offset: const Offset(0, 4),
                spreadRadius: 0,
                blurRadius: 4,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                title: 'Evidence Per Criterion',
                textStyle: Theme.of(
                  context,
                ).textTheme.headlineLarge!.copyWith(fontSize: 16.sp),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RotatedBox(
                    quarterTurns: 3,
                    child: CustomText(
                      title: 'Criterion Name',
                      textStyle: Theme.of(
                        context,
                      ).textTheme.headlineLarge!.copyWith(fontSize: 16.sp),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: EvidenceBars(data: data, maxValue: maxValue),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
