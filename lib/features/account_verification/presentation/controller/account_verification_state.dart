import 'package:qualiverse/routing/all_routes_imports.dart';

sealed class AccountVerificationState {}

class AccountVerificationInitial extends AccountVerificationState {}

class AccountVerificationLoading extends AccountVerificationState {}

class AccountVerificationSuccess extends AccountVerificationState {}

class AccountVerificationFailure extends AccountVerificationState {
  final AccountVerificationModel accountVerificationModel;

  AccountVerificationFailure({required this.accountVerificationModel});
}
