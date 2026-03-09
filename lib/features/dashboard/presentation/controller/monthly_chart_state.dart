import 'package:equatable/equatable.dart';

import '../../../../routing/all_routes_imports.dart';

abstract class MonthlyChartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MonthlyChartInitial extends MonthlyChartState {}

class MonthlyChartLoading extends MonthlyChartState {}

class MonthlyChartLoaded extends MonthlyChartState {
  final List<MonthlyChartDataModel> data;
  MonthlyChartLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class MonthlyChartError extends MonthlyChartState {
  final String message;
  MonthlyChartError(this.message);

  @override
  List<Object?> get props => [message];
}
