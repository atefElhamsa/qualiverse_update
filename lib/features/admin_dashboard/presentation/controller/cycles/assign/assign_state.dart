sealed class AssignState {}

final class AssignInitial extends AssignState {}

final class AssignLoading extends AssignState {}

final class AssignSuccess extends AssignState {
  final String message;

  AssignSuccess({required this.message});
}

final class AssignFailure extends AssignState {
  final String error;

  AssignFailure({required this.error});
}
