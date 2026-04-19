import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AssignCubit extends Cubit<AssignState> {
  AssignCubit() : super(AssignInitial());

  static AssignCubit get(BuildContext context) => BlocProvider.of(context);

  Future<bool> checkInternet() async {
    final conn = await Connectivity().checkConnectivity();
    return conn != ConnectivityResult.none;
  }

  Future<void> assign({
    required int indicatorId,
    required String doctorId,
    required String deadline,
  }) async {
    if (!await checkInternet()) {
      emit(AssignFailure(error: "checkInternet".tr()));
      return;
    }
    emit(AssignLoading());
    try {
      final result = await AssignService.assign(
        indicatorId: indicatorId,
        doctorId: doctorId,
        deadline: deadline,
      );
      emit(AssignSuccess(message: result));
    } catch (e) {
      emit(
        AssignFailure(
          error: e.toString().replaceFirst("Exception: ", "").trim(),
        ),
      );
    }
  }
}
