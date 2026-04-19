import '../../../../../../routing/all_routes_imports.dart';

sealed class CycleIndicatorState {}

final class CycleIndicatorInitial extends CycleIndicatorState {}

final class CycleIndicatorLoading extends CycleIndicatorState {}

final class CycleIndicatorLoaded extends CycleIndicatorState {
  final List<CycleIndicatorModel> cycleIndicators;

  CycleIndicatorLoaded({required this.cycleIndicators});
}

final class CycleIndicatorError extends CycleIndicatorState {
  final String error;

  CycleIndicatorError({required this.error});
}
