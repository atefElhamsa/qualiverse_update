import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordInitial());

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final currentPasswordNode = FocusNode();
  final newPasswordNode = FocusNode();
  final confirmPasswordNode = FocusNode();

  static ChangePasswordCubit get(context) => BlocProvider.of(context);

  ChangePasswordService changePasswordService = ChangePasswordService();

  Future<bool> checkInternet() async {
    final conn = await Connectivity().checkConnectivity();
    return conn != ConnectivityResult.none;
  }

  Future<void> changePasswordCubit() async {
    if (currentPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      emit(ChangePasswordError(error: "fillAllFields".tr()));
      return;
    }
    if (!await checkInternet()) {
      emit(ChangePasswordError(error: "checkInternet".tr()));
      return;
    }
    try {
      emit(ChangePasswordLoading());
      final result = await changePasswordService.changePassword(
        currentPassword: currentPasswordController.text.trim(),
        newPassword: newPasswordController.text.trim(),
        confirmNewPassword: confirmPasswordController.text.trim(),
      );
      emit(ChangePasswordSuccess(message: result));
    } catch (e) {
      emit(
        ChangePasswordError(
          error: e.toString().replaceFirst("Exception: ", "").trim(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    currentPasswordNode.dispose();
    newPasswordNode.dispose();
    confirmPasswordNode.dispose();
    return super.close();
  }
}
