import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../routing/all_routes_imports.dart';

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
              label: 'Pending Evidence',
              color: AppColors.evidenceColorSlide2,
              isSelected: state.showPending,
              onTap: cubit.togglePending,
            ),
            const LegendFilterChip(
              label: 'Approved Evidence',
              color: AppColors.mainBlack,
              isSelected: true,
              onTap: _noop,
              enabled: false,
            ),
            LegendFilterChip(
              label: 'Reviewed Evidence',
              color: AppColors.evidenceColorSlide3,
              isSelected: state.showReviewed,
              onTap: cubit.toggleReviewed,
            ),
            LegendFilterChip(
              label: 'Rejected Evidence',
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
