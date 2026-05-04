import 'package:qualiverse/features/dashboard/data/models/assignments_user_model.dart';

abstract class AssignmentsUserState {}

class AssignmentsUserInitial extends AssignmentsUserState {}

class AssignmentsUserLoading extends AssignmentsUserState {}

class AssignmentsUserSuccess extends AssignmentsUserState {
  final List<AssignmentData> assignments;
  AssignmentsUserSuccess({required this.assignments});
}

class AssignmentsUserFailure extends AssignmentsUserState {
  final String errorMessage;
  AssignmentsUserFailure({required this.errorMessage});
}
