import 'package:qualiverse/features/admin_dashboard/data/model/assignment_indicator_admin_model.dart';

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
