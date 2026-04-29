import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/evidence/evidence_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/evidence/evidence_state.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'legend_filter_chip.dart';
import 'package:easy_localization/easy_localization.dart';

class EvidenceLegendProgram extends StatelessWidget {
  const EvidenceLegendProgram({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EvidenceCubit, EvidenceState>(
      builder: (context, state) {
        if (state is! EvidenceLoaded) return const SizedBox.shrink();

        final cubit = context.read<EvidenceCubit>();

        return Wrap(
          spacing: 16,
          runSpacing: 8,
          children: [
            LegendFilterChip(
              label: 'pendingEvidence'.tr(),
              color: AppColors.evidenceColorSlide2,
              isSelected: state.showPending,
              onTap: cubit.togglePending,
            ),
            LegendFilterChip(
              label: 'approvedEvidence'.tr(),
              color: AppColors.mainBlack,
              isSelected: true,
              onTap: _noop,
              enabled: false,
            ),
            LegendFilterChip(
              label: 'reviewedEvidence'.tr(),
              color: AppColors.evidenceColorSlide3,
              isSelected: state.showReviewed,
              onTap: cubit.toggleReviewed,
            ),
            LegendFilterChip(
              label: 'rejectedEvidence'.tr(),
              color: AppColors.evidenceColorSlide4,
              isSelected: state.showRejected,
              onTap: cubit.toggleRejected,
            ),
          ],
        );
      },
    );
  }
}

void _noop() {}
