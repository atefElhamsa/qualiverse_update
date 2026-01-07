import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

sealed class IndicatorsState {}

final class IndicatorsInitial extends IndicatorsState {}

final class IndicatorsLoading extends IndicatorsState {}

final class IndicatorsSuccess extends IndicatorsState {
  final List<IndicatorModel> indicators;
  final IndicatorModel? selectedIndicator;

  IndicatorsSuccess({
    required this.indicators,
    required this.selectedIndicator,
  });
}

final class IndicatorsError extends IndicatorsState {
  final String message;

  IndicatorsError({required this.message});
}

class IndicatorUploadLoading extends IndicatorsState {
  final int indicatorId;
  IndicatorUploadLoading({required this.indicatorId});
}
