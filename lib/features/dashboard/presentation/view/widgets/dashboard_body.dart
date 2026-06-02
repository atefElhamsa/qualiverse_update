import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/assignmets/assignments_user_cubit.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';


class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<IndicatorsCubit, IndicatorsState>(
      listenWhen: (previous, current) => current is IndicatorActionError,
      listener: (context, state) {
        if (state is IndicatorActionError) {
          showSnackBar(context, state.message, AppColors.red);
        }
      },
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const DashboardScaffold(
              widget: DashboardShimmer(),
            );
          }
          if (state is DashboardFailure) {
            return Center(child: Text(state.errorMessage));
          }
          if (state is DashboardSuccess) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => EvidenceStatusCubit(
                    data: state.data.indicatorOverview?.statusDistribution
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
                    data: (state.data.indicatorOverview?.indicatorsPerCriterion)
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
                    data: state.data.accreditationStructure?.coursesPerDepartment
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
                    data: state.data.indicatorUploads
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
                    data: (state.data.programVsInstitution?.items)?.map((e) {
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
              child: DashboardScaffold(
                widget: const SingleChildScrollView(
                  child: Column(
                    children: [DashboardTopAndTitle(), DashboardTabs()],
                  ),
                ),
                onRefresh: () {
                  return context.read<DashboardCubit>().getDashboard();
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
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
