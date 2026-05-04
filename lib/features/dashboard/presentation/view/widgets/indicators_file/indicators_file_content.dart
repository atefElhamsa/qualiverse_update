import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/assignmets/assignments_user_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/assignmets/assignments_user_state.dart';
import 'package:qualiverse/features/department/presentation/controller/academic_year_cubit.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:easy_localization/easy_localization.dart';
import 'assignments_filters_row.dart';
import 'assignments_user_header_row.dart';
import 'assignments_user_row.dart';

class IndicatorsFileContent extends StatefulWidget {
  const IndicatorsFileContent({super.key});

  @override
  State<IndicatorsFileContent> createState() => _IndicatorsFileContentState();
}

class _IndicatorsFileContentState extends State<IndicatorsFileContent> {
  @override
  void initState() {
    super.initState();
    // Initial fetch if year is already selected
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final yearId = context.read<AcademicYearCubit>().selectedAcademicYear?.id;
      if (yearId != null) {
        context.read<AssignmentsUserCubit>().getAssignments(academicYearId: yearId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AssignmentsFiltersRow(),
        BlocBuilder<AssignmentsUserCubit, AssignmentsUserState>(
          builder: (context, state) {
            if (state is AssignmentsUserLoading) {
              return const Padding(
                padding: EdgeInsets.all(40.0),
                child: CustomLoading(),
              );
            }
            if (state is AssignmentsUserFailure) {
              return Center(child: Text(state.errorMessage));
            }
            if (state is AssignmentsUserSuccess) {
              if (state.assignments.isEmpty) {
                return Padding(
                  padding: const EdgeInsets.all(80.0),
                  child: Center(
                    child: CustomText(
                      title: 'noDataFound'.tr(),
                      textStyle: Theme.of(context).textTheme.headlineLarge!,
                    ),
                  ),
                );
              }
              return Column(
                children: [
                  const AssignmentsUserHeaderRow(),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.assignments.length,
                    itemBuilder: (context, index) {
                      return AssignmentsUserRow(
                        assignment: state.assignments[index],
                      );
                    },
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }
}
