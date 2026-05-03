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

  Future<void> assignIndicator({
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
      final result = await AssignService.assignIndicator(
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

  Future<void> removeAssignIndicator({required int indicatorId}) async {
    if (!await checkInternet()) {
      emit(AssignFailure(error: "checkInternet".tr()));
      return;
    }
    emit(DeleteAssignLoading());
    try {
      final result = await AssignService.removeAssignIndicator(
        indicatorId: indicatorId,
      );
      emit(DeleteAssignSuccess(message: result));
    } catch (e) {
      emit(
        AssignFailure(
          error: e.toString().replaceFirst("Exception: ", "").trim(),
        ),
      );
    }
  }

  Future<void> assignCourse({
    required int courseId,
    required String doctorId,
  }) async {
    if (!await checkInternet()) {
      emit(AssignFailure(error: "checkInternet".tr()));
      return;
    }
    emit(AssignLoading());
    try {
      final result = await AssignService.assignCourse(
        courseId: courseId,
        doctorId: doctorId,
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

  Future<void> removeAssignCourse({required int courseId}) async {
    if (!await checkInternet()) {
      emit(AssignFailure(error: "checkInternet".tr()));
      return;
    }
    emit(DeleteAssignLoading());
    try {
      final result = await AssignService.removeAssignCourse(courseId: courseId);
      emit(DeleteAssignSuccess(message: result));
      
    } catch (e) {
      emit(
        AssignFailure(
          error: e.toString().replaceFirst("Exception: ", "").trim(),
        ),
      );
    }
  }
}
