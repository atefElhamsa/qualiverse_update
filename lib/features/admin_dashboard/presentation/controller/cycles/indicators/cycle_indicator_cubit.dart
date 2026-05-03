import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../routing/all_routes_imports.dart';

class CycleIndicatorCubit extends Cubit<CycleIndicatorState> {
  CycleIndicatorCubit() : super(CycleIndicatorInitial());

  static CycleIndicatorCubit get(BuildContext context) =>
      BlocProvider.of(context);

  List<CycleIndicatorModel> cycleIndicators = [];

  Future<void> fetchCycleIndicators({
    required int yearId,
    int? departmentId,
    required int criterionId,
  }) async {
    emit(CycleIndicatorLoading());
    try {
      final data = await CyclesIndicatorService.getCycleIndicators(
        yearId: yearId,
        departmentId: departmentId,
        criterionId: criterionId,
      );
      cycleIndicators = data;
      emit(CycleIndicatorLoaded(cycleIndicators: cycleIndicators));
    } catch (e) {
      emit(CycleIndicatorError(error: e.toString()));
    }
  }

  Future<void> deleteCycleIndicator({required int indicatorId}) async {
    emit(CycleIndicatorActionLoading());
    try {
      final msg = await CyclesIndicatorService.deleteCycleIndicator(
        indicatorId: indicatorId,
      );
      emit(CycleIndicatorDeleteSuccess(msg: msg));
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('No Internet')) {
        emit(CycleIndicatorActionError(error: 'Check your internet connection'));
      } else if (msg.contains('Unauthorized')) {
        reset();
      } else {
        emit(CycleIndicatorActionError(error: 'Something went wrong'));
      }
    }
  }

  Future<void> createNewIndicator({
    required int criterionId,
    required String nameAr,
    required String descriptionAr,
    required String nameEn,
    required String descriptionEn,
  }) async {
    emit(CycleIndicatorActionLoading());
    try {
      final message = await CyclesIndicatorService.createNewIndicator(
        criterionId: criterionId,
        nameAr: nameAr,
        descriptionAr: descriptionAr,
        nameEn: nameEn,
        descriptionEn: descriptionEn,
      );
      emit(CycleIndicatorCreateSuccess(message: message));
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('No Internet')) {
        emit(CycleIndicatorActionError(error: 'Check your internet connection'));
      } else if (msg.contains('Unauthorized')) {
        reset();
      } else {
        emit(CycleIndicatorActionError(error: msg));
      }
    }
  }

  void reset() {
    cycleIndicators = [];
    emit(CycleIndicatorInitial());
  }
}
