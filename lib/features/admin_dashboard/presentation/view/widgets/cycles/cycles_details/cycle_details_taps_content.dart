import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/view/widgets/cycles/cycles_details/assignments/assignments_content.dart';

import '../../../../../../../routing/all_routes_imports.dart';
import '../../../../controller/cycles/assignments/assignment_status_cubit.dart';
import '../../../../controller/cycles/assignments/assignments_cubit.dart';

class CycleDetailsTapsContent extends StatelessWidget {
  const CycleDetailsTapsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CycleTabsCubit, CycleTabsState>(
      listener: (context, state) {
        ProgramAccreditationCubit.get(context).reset();
        AssignmentsCubit.get(context).reset();
        AssignmentStatusCubit.get(context).resetSelection();
      },
      child: BlocBuilder<CycleTabsCubit, CycleTabsState>(
        builder: (context, state) {
          final currentTab = context.watch<CycleTabsCubit>().currentTab;

          switch (currentTab) {
            case CycleTab.courses:
              return const CoursesContent();

            case CycleTab.criterions:
              return const CriterionsContent();

            case CycleTab.indicators:
              return const IndicatorsContent();

            case CycleTab.assignments:
              return AssignmentsContent();
          }
        },
      ),
    );
  }
}
