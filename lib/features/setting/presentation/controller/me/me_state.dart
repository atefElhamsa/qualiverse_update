import '../../../../../routing/all_routes_imports.dart';

abstract class MeState {}

class MeInitial extends MeState {}

class MeLoading extends MeState {}

class MeSuccess extends MeState {
  final MeModel meModel;

  MeSuccess({required this.meModel});
}

class MeFailure extends MeState {
  final String error;

  MeFailure({required this.error});
}
