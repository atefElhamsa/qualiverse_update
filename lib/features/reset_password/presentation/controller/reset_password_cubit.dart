import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../reset_password_imports/reset_password_imports.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());

  static ResetPasswordCubit of(BuildContext context) =>
      BlocProvider.of<ResetPasswordCubit>(context);

  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final passwordController = TextEditingController();

  final emailNode = FocusNode();
  final otpNode = FocusNode();
  final passwordNode = FocusNode();

  final ResetPasswordService resetPasswordService = ResetPasswordService();

  Future<bool> _checkInternet() async {
    final conn = await Connectivity().checkConnectivity();
    return conn != ConnectivityResult.none;
  }

  Future<void> forgetPasswordCubit() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      emit(ResetPasswordFailure(errorMessage: "emailValidation".tr()));
      return;
    }

    if (!await _checkInternet()) {
      emit(ResetPasswordFailure(errorMessage: "checkInternet".tr()));
      return;
    }

    try {
      emit(ResetPasswordLoading());

      final result = await resetPasswordService.resetPassword(email: email);

      emit(ResetPasswordSuccess(message: result));
    } catch (e) {
      emit(
        ResetPasswordFailure(
          errorMessage: e.toString().replaceFirst("Exception: ", "").trim(),
        ),
      );
    }
  }

  Future<void> resetPasswordCubit() async {
    final email = emailController.text.trim();
    final otp = otpController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || otp.isEmpty || password.isEmpty) {
      emit(ResetPasswordFailure(errorMessage: "fillAllFields".tr()));
      return;
    }
    if (!await _checkInternet()) {
      emit(ResetPasswordFailure(errorMessage: "checkInternet".tr()));
      return;
    }

    try {
      emit(ResetPasswordOtpLoading());

      final result = await resetPasswordService.resetPasswordOtp(
        email: email,
        otp: otp,
        newPassword: password,
      );

      emit(ResetPasswordOtpSuccess(message: result));
    } catch (e) {
      emit(
        ResetPasswordFailure(
          errorMessage: e.toString().replaceFirst("Exception: ", "").trim(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    otpController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    otpNode.dispose();
    passwordNode.dispose();
    return super.close();
  }
}
