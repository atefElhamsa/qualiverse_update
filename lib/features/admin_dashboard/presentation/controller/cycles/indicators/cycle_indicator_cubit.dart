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
    int? criterionId,
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

  void reset() {
    cycleIndicators = [];
    emit(CycleIndicatorInitial());
  }
}
