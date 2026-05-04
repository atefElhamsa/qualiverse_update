import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_state.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/evidence_status/evidence_status_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/evidence_per_criterion/evidence_per_criterion_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/courses_per_department/courses_per_department_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/monthly_chart/monthly_chart_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/evidence/evidence_cubit.dart';
import 'package:qualiverse/features/dashboard/data/models/chart_data_model.dart';
import 'package:qualiverse/features/dashboard/data/models/criterion_data_model.dart';
import 'package:qualiverse/features/dashboard/data/models/department_data_model.dart';
import 'package:qualiverse/features/dashboard/data/models/monthly_chart_data_model.dart';
import 'package:qualiverse/features/dashboard/data/models/evidence_data_model.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/assignmets/assignments_user_cubit.dart';

import 'dashboard_scaffold.dart';
import 'dashboard_top_and_title.dart';
import 'dashboard_tabs.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state is DashboardLoading) {
          return const Center(child: CustomLoading());
        }
        if (state is DashboardFailure) {
          return Center(child: Text(state.errorMessage));
        }
        if (state is DashboardSuccess) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => EvidenceStatusCubit(
                  data:
                      state.data.indicatorOverview?.statusDistribution
                          ?.map(
                            (e) => ChartDataModel(
                              label: e.status ?? '',
                              value: (e.count ?? 0).toDouble(),
                              color: _getStatusColor(e.status),
                            ),
                          )
                          .toList() ??
                      [],
                ),
              ),
              BlocProvider(
                create: (_) => EvidencePerCriterionCubit(
                  data:
                      (state.data.indicatorOverview?.indicatorsPerCriterion)
                          ?.map((e) {
                            if (e is! Map) {
                              return const CriterionDataModel(
                                label: '',
                                value: 0,
                              );
                            }
                            return CriterionDataModel(
                              label: e['criterionName']?.toString() ?? '',
                              value: (e['count'] ?? 0).toDouble(),
                            );
                          })
                          .toList() ??
                      [],
                )..loadData(),
              ),
              BlocProvider(
                create: (_) => CoursesPerDepartmentCubit(
                  data:
                      state.data.accreditationStructure?.coursesPerDepartment
                          ?.map(
                            (e) => DepartmentDataModel(
                              label: e.departmentName ?? '',
                              value: (e.count ?? 0).toDouble(),
                            ),
                          )
                          .toList() ??
                      [],
                )..loadData(),
              ),
              BlocProvider(
                create: (_) => MonthlyChartCubit(
                  data:
                      state.data.indicatorUploads
                          ?.map(
                            (e) => MonthlyChartDataModel(
                              month: e.month ?? '',
                              value: (e.count ?? 0).toDouble(),
                            ),
                          )
                          .toList() ??
                      [],
                ),
              ),
              BlocProvider(
                create: (_) => EvidenceCubit(
                  data:
                      (state.data.programVsInstitution?.items)?.map((e) {
                        if (e is! Map) {
                          return EvidenceDataModel(
                            criterion: '',
                            pending: 0,
                            reviewed: 0,
                            rejected: 0,
                          );
                        }
                        return EvidenceDataModel(
                          criterion: e['criterion']?.toString() ?? '',
                          pending: e['pending'] ?? 0,
                          reviewed: e['reviewed'] ?? 0,
                          rejected: e['rejected'] ?? 0,
                        );
                      }).toList() ??
                      [],
                )..loadData(),
              ),
              BlocProvider(create: (context) => AssignmentsUserCubit()),
            ],
            child: const DashboardScaffold(
              widget: SingleChildScrollView(
                child: Column(
                  children: [DashboardTopAndTitle(), DashboardTabs()],
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Approved':
        return AppColors.approvedColorIndicator; // أخضر
      case 'Pending':
        return AppColors.pendingColorIndicator; // برتقالي/أصفر
      case 'Submitted':
        return AppColors.reviewedColor; // أزرق
      case 'Rejected':
        return AppColors.rejectedColorIndicator; // أحمر
      default:
        return AppColors.grey;
    }
  }
}
