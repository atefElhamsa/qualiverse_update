import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routing/all_routes_imports.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  LogoutService logoutService = LogoutService();

  static LogoutCubit get(context) => BlocProvider.of(context);

  Future<bool> checkInternet() async {
    final conn = await Connectivity().checkConnectivity();
    return conn != ConnectivityResult.none;
  }

  Future<void> logoutCubit() async {
    if (!await checkInternet()) {
      emit(LogoutError(error: "checkInternet".tr()));
      return;
    }
    try {
      emit(LogoutLoading());
      final result = await logoutService.logout();
      emit(LogoutSuccess(message: result));
    } catch (e) {
      print(e.toString());
      emit(
        LogoutError(error: e.toString().replaceFirst("Exception: ", "").trim()),
      );
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
