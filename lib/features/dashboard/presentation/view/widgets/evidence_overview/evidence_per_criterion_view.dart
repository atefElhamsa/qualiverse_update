import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/evidence_per_criterion/evidence_per_criterion_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/evidence_per_criterion/evidence_per_criterion_state.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'evidence_bars.dart';
import 'package:easy_localization/easy_localization.dart';

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
        final maxValue = data.isEmpty ? 1.0 : data.map((d) => d.value).reduce((a, b) => a > b ? a : b);
        final displayMaxValue = maxValue == 0 ? 1.0 : maxValue;
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
                ? AppColors.grey
                : AppColors.mainBlack,
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
                title: 'evidencePerCriterion'.tr(),
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
                      title: 'criterionName'.tr(),
                      textStyle: Theme.of(
                        context,
                      ).textTheme.headlineLarge!.copyWith(fontSize: 16.sp),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: EvidenceBars(data: data, maxValue: displayMaxValue),
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
