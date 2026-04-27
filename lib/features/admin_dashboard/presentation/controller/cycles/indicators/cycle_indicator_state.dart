import '../../../../../../routing/all_routes_imports.dart';

sealed class CycleIndicatorState {}

final class CycleIndicatorInitial extends CycleIndicatorState {}

final class CycleIndicatorLoading extends CycleIndicatorState {}

final class CycleIndicatorActionLoading extends CycleIndicatorState {}

final class CycleIndicatorDeleteSuccess extends CycleIndicatorState {
  final String msg;

  CycleIndicatorDeleteSuccess({required this.msg});
}

final class CycleIndicatorLoaded extends CycleIndicatorState {
  final List<CycleIndicatorModel> cycleIndicators;

  CycleIndicatorLoaded({required this.cycleIndicators});
}

final class CycleIndicatorError extends CycleIndicatorState {
  final String error;

  CycleIndicatorError({required this.error});
}

final class CycleIndicatorActionError extends CycleIndicatorState {
  final String error;

  CycleIndicatorActionError({required this.error});
}
