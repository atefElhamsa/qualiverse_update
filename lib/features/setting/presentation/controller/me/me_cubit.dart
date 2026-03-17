import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class MeCubit extends Cubit<MeState> {
  MeCubit() : super(MeInitial());

  static MeCubit get(BuildContext context) => BlocProvider.of(context);

  final MeService meService = MeService();

  Future<bool> checkInternet() async {
    final conn = await Connectivity().checkConnectivity();
    return conn != ConnectivityResult.none;
  }

  Future<void> getMyInfo() async {
    if (!await checkInternet()) {
      emit(MeFailure(error: "checkInternet".tr()));
      return;
    }
    try {
      emit(MeLoading());
      final result = await meService.myInfo();
      emit(MeSuccess(meModel: result));
    } catch (e) {
      emit(
        MeFailure(error: e.toString().replaceFirst("Exception: ", "").trim()),
      );
    }
  }
}
