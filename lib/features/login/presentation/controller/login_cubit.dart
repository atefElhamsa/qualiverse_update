import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final userNameOrEmailController = TextEditingController();
  final passwordController = TextEditingController();

  final userNameOrEmailNode = FocusNode();
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
    if (userNameOrEmailController.text.isEmpty ||
        passwordController.text.isEmpty) {
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
        userNameOrEmail: userNameOrEmailController.text.trim(),
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
        key: KeysTexts.userNameOrEmail,
        value: userNameOrEmailController.text.trim(),
      );
      await CashHelper.saveData(
        key: KeysTexts.userPassword,
        value: passwordController.text.trim(),
      );

      emit(LoginSuccess(user: result));
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
    userNameOrEmailController.dispose();
    passwordController.dispose();
    userNameOrEmailNode.dispose();
    passwordNode.dispose();
    return super.close();
  }
}
