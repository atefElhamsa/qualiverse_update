import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routing/all_routes_imports.dart';

class AccountVerificationCubit extends Cubit<AccountVerificationState> {
  AccountVerificationCubit() : super(AccountVerificationInitial());

  final emailController = TextEditingController();
  final emailNode = FocusNode();

  final AccountVerificationService service = AccountVerificationService();

  Future<bool> checkInternet() async {
    final conn = await Connectivity().checkConnectivity();
    return conn != ConnectivityResult.none;
  }

  Future<void> verificationAccountCubit(BuildContext context) async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      emit(AccountVerificationFailure(errorMessage: 'Email is required'));
      return;
    }

    if (!await checkInternet()) {
      emit(AccountVerificationFailure(errorMessage: 'No Internet Connection'));
      return;
    }

    try {
      emit(AccountVerificationLoading());

      await service.verificationAccount(email: email);

      emit(AccountVerificationSuccess());
    } catch (e) {
      emit(
        AccountVerificationFailure(
          errorMessage: e.toString().replaceFirst('Exception: ', '').trim(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    emailNode.dispose();
    return super.close();
  }
}
