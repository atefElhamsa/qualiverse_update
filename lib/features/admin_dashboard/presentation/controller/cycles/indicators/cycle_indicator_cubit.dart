import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../routing/all_routes_imports.dart';

class CycleIndicatorCubit extends Cubit<CycleIndicatorState> {
  CycleIndicatorCubit() : super(CycleIndicatorInitial());

  static CycleIndicatorCubit get(BuildContext context) =>
      BlocProvider.of(context);

  List<CycleIndicatorModel> cycleIndicators = [];

  int? _lastYearId;
  int? _lastDepartmentId;
  int? _lastCriterionId;

  Future<void> fetchCycleIndicators({
    required int yearId,
    int? departmentId,
    int? criterionId,
  }) async {
    // ✅ Cache params for later refresh
    _lastYearId = yearId;
    _lastDepartmentId = departmentId;
    _lastCriterionId = criterionId;

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
      final msg = e.toString();
      if (msg.contains('No Internet')) {
        emit(CycleIndicatorError(error: 'Check your internet connection'));
      } else if (msg.contains('Unauthorized')) {
        reset();
      } else {
        emit(CycleIndicatorError(error: 'Something went wrong'));
      }
    }
  }

  /// Re-fetches using the last used params — call this after any mutation.
  Future<void> refresh() async {
    if (_lastYearId == null) return;
    await fetchCycleIndicators(
      yearId: _lastYearId!,
      departmentId: _lastDepartmentId,
      criterionId: _lastCriterionId,
    );
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
