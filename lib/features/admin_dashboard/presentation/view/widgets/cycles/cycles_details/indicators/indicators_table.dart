import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../routing/all_routes_imports.dart';

// class IndicatorsTable extends StatefulWidget {
//   const IndicatorsTable({super.key});
//
//   @override
//   State<IndicatorsTable> createState() => _IndicatorsTableState();
// }
//
// class _IndicatorsTableState extends State<IndicatorsTable> {
//   @override
//   void initState() {
//     super.initState();
//     CycleIndicatorCubit.get(context).fetchCycleIndicators(
//       yearId: AcademicYearCubit.get(context).selectedAcademicYear!.id,
//       departmentId: DepartmentCubit.get(context).selectedDepartment!.id,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CycleIndicatorCubit, CycleIndicatorState>(
//       builder: (context, state) {
//         if (state is CycleIndicatorLoading) {
//           return const CustomLoading();
//         }
//         if (state is CycleIndicatorError) {
//           return RetryWidget(
//             title: state.error,
//             onPressed: () {
//               CycleIndicatorCubit.get(context).fetchCycleIndicators(
//                 yearId: AcademicYearCubit.get(context).selectedAcademicYear!.id,
//                 departmentId: DepartmentCubit.get(
//                   context,
//                 ).selectedDepartment!.id,
//                 criterionId: ProgramAccreditationCubit.get(
//                   context,
//                 ).selectedProgramAccreditation!.id,
//               );
//             },
//           );
//         }
//         if (state is CycleIndicatorLoaded) {
//           final cycleIndicators = state.cycleIndicators;
//           return cycleIndicators.isEmpty
//               ? Center(
//                   child: CustomText(
//                     title: 'No Indicators',
//                     textStyle: Theme.of(context).textTheme.headlineLarge!,
//                   ),
//                 )
//               : Column(
//                   children: [
//                     const IndicatorsHeader(),
//                     ...cycleIndicators.asMap().entries.map(
//                       (entry) => IndicatorsRowWidget(
//                         cycleIndicator: entry.value,
//                         index: entry.key,
//                         total: cycleIndicators.length,
//                       ),
//                     ),
//                   ],
//                 );
//         }
//         return const SizedBox();
//       },
//     );
//   }
// }

class IndicatorsTable extends StatefulWidget {
  const IndicatorsTable({super.key});

  @override
  State<IndicatorsTable> createState() => _IndicatorsTableState();
}

class _IndicatorsTableState extends State<IndicatorsTable> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) fetchIfReady();
    });
  }

  void fetchIfReady() {
    if (!mounted) return;

    final yearId = AcademicYearCubit.get(context).selectedAcademicYear?.id;
    final departmentId = DepartmentCubit.get(context).selectedDepartment?.id;
    final criterionId = ProgramAccreditationCubit.get(
      context,
    ).selectedProgramAccreditation?.id;

    if (yearId != null && departmentId != null && criterionId != null) {
      CycleIndicatorCubit.get(context).fetchCycleIndicators(
        yearId: yearId,
        departmentId: departmentId,
        criterionId: criterionId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CycleIndicatorCubit, CycleIndicatorState>(
      builder: (context, state) {
        if (state is CycleIndicatorLoading) {
          return const CustomLoading();
        }
        if (state is CycleIndicatorError) {
          return RetryWidget(title: state.error, onPressed: fetchIfReady);
        }
        if (state is CycleIndicatorLoaded) {
          final cycleIndicators = state.cycleIndicators;
          return cycleIndicators.isEmpty
              ? Center(
                  child: CustomText(
                    title: 'No Indicators',
                    textStyle: Theme.of(context).textTheme.headlineLarge!,
                  ),
                )
              : Column(
                  children: [
                    const IndicatorsHeader(),
                    ...cycleIndicators.asMap().entries.map(
                      (entry) => IndicatorsRowWidget(
                        cycleIndicator: entry.value,
                        index: entry.key,
                        total: cycleIndicators.length,
                      ),
                    ),
                  ],
                );
        }
        return const SizedBox();
      },
    );
  }
}
