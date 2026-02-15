import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  static SignUpCubit of(BuildContext context) =>
      BlocProvider.of<SignUpCubit>(context);

  // Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // FocusNodes
  final firstNameNode = FocusNode();
  final lastNameNode = FocusNode();
  final userNameNode = FocusNode();
  final emailNode = FocusNode();
  final passwordNode = FocusNode();
  final confirmPasswordNode = FocusNode();

  final SignUpServices signUpServices = SignUpServices();

  Future<bool> _checkInternet() async {
    final conn = await Connectivity().checkConnectivity();
    return conn != ConnectivityResult.none;
  }

  Future<void> signUpCubit() async {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final userName = userNameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    // Basic validation
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        userName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      emit(SignUpFailure(errorMessage: "fillAllFields".tr()));
      return;
    }

    if (firstName.length < 3) {
      emit(SignUpFailure(errorMessage: "firstNameTooShort".tr()));
      return;
    }

    if (lastName.length < 3) {
      emit(SignUpFailure(errorMessage: "lastNameTooShort".tr()));
      return;
    }

    if (password != confirmPassword) {
      emit(SignUpFailure(errorMessage: "passwordValidation".tr()));
      return;
    }

    if (!await _checkInternet()) {
      emit(SignUpFailure(errorMessage: "checkInternet".tr()));
      return;
    }

    try {
      emit(SignUpLoading());

      final result = await signUpServices.signUp(
        firstName: firstName,
        lastName: lastName,
        userName: userName,
        email: email,
        password: password,
        confirmPassword: confirmPassword,
      );

      emit(SignUpSuccess(message: result));
    } catch (e) {
      emit(
        SignUpFailure(
          errorMessage: e.toString().replaceFirst("Exception: ", "").trim(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    firstNameNode.dispose();
    lastNameNode.dispose();
    userNameNode.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    confirmPasswordNode.dispose();

    return super.close();
  }
}
