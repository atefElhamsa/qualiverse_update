import 'package:qualiverse/routing/all_routes_imports.dart';

abstract class DashboardOverviewState {}

class DashboardOverviewInitial extends DashboardOverviewState {}

class DashboardOverviewLoading extends DashboardOverviewState {}

class DashboardOverviewSuccess extends DashboardOverviewState {
  final DashboardTotalsModel totals;
  final List<DepartmentProgressModel> departmentProgress;
  final InstitutionalProgressModel institutionalProgress;

  DashboardOverviewSuccess({
    required this.totals,
    required this.departmentProgress,
    required this.institutionalProgress,
  });
}

class DashboardOverviewError extends DashboardOverviewState {
  final String message;

  DashboardOverviewError({required this.message});
}
