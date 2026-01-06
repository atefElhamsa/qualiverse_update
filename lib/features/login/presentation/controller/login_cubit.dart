import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailNode = FocusNode();
  final passwordNode = FocusNode();
  bool rememberMe = false;

  static LoginCubit get(context) => BlocProvider.of(context);

  LoginServices loginServices = LoginServices();

  void toggleRememberMe({required bool value}) {
    rememberMe = value;
    if (!value) {
      LoginStorage.clear();
    }
    emit(LoginInitial());
  }

  Future<bool> checkInternet() async {
    final conn = await Connectivity().checkConnectivity();
    return conn != ConnectivityResult.none;
  }

  Future<void> loginCubit(BuildContext context) async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      emit(LoginFailure(errorMessage: "fillAllFields".tr()));
      return;
    }

    if (!await checkInternet()) {
      emit(LoginFailure(errorMessage: "checkInternet".tr()));
      return;
    }

    try {
      emit(LoginLoading());
      final result = await loginServices.login(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      LoginStorage.setSession(
        tokenValue: result.token,
        refreshTokenValue: result.refreshToken,
        refreshTokenExpirationValue: result.refreshTokenExpiration,
      );

      LoginInterceptor().reset();

      if (rememberMe) {
        await LoginStorage.savePersistent();
      }

      await CashHelper.saveData(
        key: KeysTexts.userEmail,
        value: emailController.text.trim(),
      );
      await CashHelper.saveData(
        key: KeysTexts.userPassword,
        value: passwordController.text.trim(),
      );

      emit(LoginSuccess(loginModel: result));
      context.read<SettingCubit>().refreshUserData();
    } catch (e) {
      emit(
        LoginFailure(
          errorMessage: e.toString().replaceFirst("Exception: ", "").trim(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    return super.close();
  }
}
