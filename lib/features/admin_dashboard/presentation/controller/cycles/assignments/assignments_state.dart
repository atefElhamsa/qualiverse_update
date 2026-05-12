import 'package:qualiverse/routing/all_routes_imports.dart';

abstract class AssignmentsState {}

class AssignmentsInitial extends AssignmentsState {}

class AssignmentsLoading extends AssignmentsState {}

class AssignmentsLoaded extends AssignmentsState {
  final List<AssignmentIndicatorAdminModel> assignments;
  AssignmentsLoaded({required this.assignments});
}

class AssignmentsError extends AssignmentsState {
  final String error;
  AssignmentsError({required this.error});
}
