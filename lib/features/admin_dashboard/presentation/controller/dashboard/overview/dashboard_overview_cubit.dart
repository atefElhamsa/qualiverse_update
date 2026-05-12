import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class DashboardOverviewCubit extends Cubit<DashboardOverviewState> {
  DashboardOverviewCubit() : super(DashboardOverviewInitial());

  static DashboardOverviewCubit get(BuildContext context) =>
      BlocProvider.of(context);

  DashboardTotalsModel? totals;
  List<DepartmentProgressModel>? departmentProgress;
  InstitutionalProgressModel? institutionalProgress;

  Future<void> getAllDashboardData({required int yearId}) async {
    emit(DashboardOverviewLoading());
    try {
      await Future.wait([
        getDashboardTotals(yearId: yearId, emitState: false),
        getDepartmentProgress(yearId: yearId, emitState: false),
        getInstitutionalProgress(yearId: yearId, emitState: false),
      ]);
      _emitSuccess();
    } catch (e) {
      emit(DashboardOverviewError(message: e.toString()));
    }
  }

  Future<void> getDashboardTotals({
    required int yearId,
    bool emitState = true,
  }) async {
    if (emitState) emit(DashboardOverviewLoading());
    try {
      final result = await DashboardOverviewService.getDashboardTotals(
        yearId: yearId,
      );
      totals = result.data;
      if (emitState) _emitSuccess();
    } catch (e) {
      if (emitState) emit(DashboardOverviewError(message: e.toString()));
      rethrow;
    }
  }

  Future<void> getDepartmentProgress({
    required int yearId,
    bool emitState = true,
  }) async {
    if (emitState) emit(DashboardOverviewLoading());
    try {
      final result = await DashboardOverviewService.getDepartmentProgress(
        yearId: yearId,
      );
      departmentProgress = result.data;
      if (emitState) _emitSuccess();
    } catch (e) {
      if (emitState) emit(DashboardOverviewError(message: e.toString()));
      rethrow;
    }
  }

  Future<void> getInstitutionalProgress({
    required int yearId,
    bool emitState = true,
  }) async {
    if (emitState) emit(DashboardOverviewLoading());
    try {
      final result = await DashboardOverviewService.getInstitutionalProgress(
        yearId: yearId,
      );
      institutionalProgress = result.data;
      if (emitState) _emitSuccess();
    } catch (e) {
      if (emitState) emit(DashboardOverviewError(message: e.toString()));
      rethrow;
    }
  }

  void _emitSuccess() {
    if (totals != null &&
        departmentProgress != null &&
        institutionalProgress != null) {
      emit(
        DashboardOverviewSuccess(
          totals: totals!,
          departmentProgress: departmentProgress!,
          institutionalProgress: institutionalProgress!,
        ),
      );
    }
  }
}
