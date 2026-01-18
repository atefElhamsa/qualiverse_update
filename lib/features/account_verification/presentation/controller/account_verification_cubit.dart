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
    if (emailController.text.isEmpty) {
      emit(
        AccountVerificationFailure(
          accountVerificationModel: const AccountVerificationModel(
            type: '',
            title: 'Validation Error',
            status: 0,
            errors: ['Email is required'],
          ),
        ),
      );
      return;
    }

    if (!await checkInternet()) {
      emit(
        AccountVerificationFailure(
          accountVerificationModel: const AccountVerificationModel(
            type: '',
            title: 'Network Error',
            status: 0,
            errors: ['No Internet Connection'],
          ),
        ),
      );
      return;
    }

    try {
      emit(AccountVerificationLoading());

      await service.verificationAccount(email: emailController.text.trim());

      emit(AccountVerificationSuccess());
    } on AccountVerificationModel catch (model) {
      emit(AccountVerificationFailure(accountVerificationModel: model));
    } catch (e) {
      emit(
        AccountVerificationFailure(
          accountVerificationModel: AccountVerificationModel(
            type: '',
            title: 'Unknown Error',
            status: 0,
            errors: [e.toString().replaceFirst('Exception: ', '').trim()],
          ),
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
