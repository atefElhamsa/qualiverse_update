import 'package:qualiverse/features/dashboard/data/models/dashboard_response_model.dart';

abstract class DashboardState {}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardSuccess extends DashboardState {
  final DashboardData data;
  DashboardSuccess({required this.data});
}

class DashboardFailure extends DashboardState {
  final String errorMessage;
  DashboardFailure({required this.errorMessage});
}
