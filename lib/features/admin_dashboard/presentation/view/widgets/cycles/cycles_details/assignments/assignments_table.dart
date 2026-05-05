import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/controller/cycles/assignments/assignments_cubit.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/controller/cycles/assignments/assignments_state.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';
import 'assignments_header.dart';
import 'assignments_row_widget.dart';

class AssignmentsTable extends StatelessWidget {
  const AssignmentsTable({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssignmentsCubit, AssignmentsState>(
      builder: (context, state) {
        if (state is AssignmentsLoading || state is AssignmentsInitial) {
          return const Center(child: CustomLoading());
        }
        if (state is AssignmentsError) {
          return Center(
            child: RetryWidget(
              title: state.error,
              onPressed: () {
                final yearId = AcademicYearCubit.get(
                  context,
                ).selectedAcademicYear?.id;
                if (yearId != null) {
                  AssignmentsCubit.get(
                    context,
                  ).fetchAssignments(academicYearId: yearId);
                }
              },
            ),
          );
        }
        if (state is AssignmentsLoaded) {
          final assignments = state.assignments;
          return assignments.isEmpty
                ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CustomText(
                      title: 'noAssignments'.tr(),
                      textStyle: Theme.of(context).textTheme.headlineLarge!,
                    ),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      const AssignmentsHeader(),
                      ...assignments.asMap().entries.map(
                        (entry) => AssignmentsRowWidget(
                          assignment: entry.value,
                          index: entry.key,
                          total: assignments.length,
                        ),
                      ),
                    ],
                  ),
                );
        }
        return const SizedBox();
      },
    );
  }
}
