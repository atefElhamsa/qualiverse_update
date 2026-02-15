sealed class AccountVerificationState {}

class AccountVerificationInitial extends AccountVerificationState {}

class AccountVerificationLoading extends AccountVerificationState {}

class AccountVerificationSuccess extends AccountVerificationState {}

class AccountVerificationFailure extends AccountVerificationState {
  final String errorMessage;

  AccountVerificationFailure({required this.errorMessage});
}
