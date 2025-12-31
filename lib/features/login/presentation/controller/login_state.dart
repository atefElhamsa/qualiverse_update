import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final LoginModel loginModel;

  LoginSuccess({required this.loginModel});
}

final class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure({required this.errorMessage});
}
