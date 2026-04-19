import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../routing/all_routes_imports.dart';

class CycleDetailsTapsContent extends StatelessWidget {
  const CycleDetailsTapsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CycleTabsCubit, CycleTabsState>(
      builder: (context, state) {
        final cubit = context.read<CycleTabsCubit>();

        switch (cubit.currentTab) {
          case CycleTab.overview:
            return const OverviewContent();

          case CycleTab.courses:
            return const CoursesContent();

          case CycleTab.criterions:
            return const CriterionsContent();

          case CycleTab.indicators:
            return const IndicatorsContent();

          case CycleTab.assignments:
            return const AssignmentsContent();
        }
      },
    );
  }
}
