import 'package:qualiverse/features/admin_dashboard/data/model/assignment_state_model.dart';

abstract class AssignmentStatusState {}

class AssignmentStatusInitial extends AssignmentStatusState {}

class AssignmentStatusLoading extends AssignmentStatusState {}

class AssignmentStatusSuccess extends AssignmentStatusState {
  final List<AssignmentStateModel> statuses;
  AssignmentStatusSuccess({required this.statuses});
}

class AssignmentStatusError extends AssignmentStatusState {
  final String error;
  AssignmentStatusError({required this.error});
}