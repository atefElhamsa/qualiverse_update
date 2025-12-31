sealed class ResetPasswordState {}

final class ResetPasswordInitial extends ResetPasswordState {}

final class ResetPasswordLoading extends ResetPasswordState {}

final class ResetPasswordSuccess extends ResetPasswordState {
  final String message;

  ResetPasswordSuccess({required this.message});
}

final class ResetPasswordFailure extends ResetPasswordState {
  final String errorMessage;

  ResetPasswordFailure({required this.errorMessage});
}
