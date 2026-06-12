import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class MeCubit extends Cubit<MeState> {
  MeCubit() : super(MeInitial()) {
    loadCachedInfo();
  }

  static MeCubit get(BuildContext context) => BlocProvider.of(context);

  final MeService meService = MeService();

  Future<bool> checkInternet() async {
    final conn = await Connectivity().checkConnectivity();
    return !conn.contains(ConnectivityResult.none);
  }

  void loadCachedInfo() {
    final cachedData = CashHelper.getData(key: KeysTexts.meModel);
    if (cachedData != null) {
      try {
        final decoded = jsonDecode(cachedData);
        final meModel = MeModel.fromJson(decoded);
        emit(MeSuccess(meModel: meModel));
      } catch (e) {
        // Silent catch
      }
    }
  }

  Future<void> getMyInfo() async {
    final hasInternet = await checkInternet();
    final hasCachedInfo = state is MeSuccess;

    if (!hasInternet) {
      if (!hasCachedInfo) {
        emit(MeFailure(error: "checkInternet".tr()));
      }
      return;
    }

    try {
      if (!hasCachedInfo) {
        emit(MeLoading());
      }
      final result = await meService.myInfo();

      await CashHelper.saveData(
        key: KeysTexts.meModel,
        value: jsonEncode(result.toJson()),
      );

      emit(MeSuccess(meModel: result));
    } catch (e) {
      if (!hasCachedInfo) {
        emit(
          MeFailure(error: e.toString().replaceFirst("Exception: ", "").trim()),
        );
      }
    }
  }

  void reset() {
    emit(MeInitial());
  }
}
