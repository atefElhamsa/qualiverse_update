import 'package:qualiverse/routing/all_routes_imports.dart';

sealed class GetFileDataState {}

class GetFileDataInitial extends GetFileDataState {}

class GetFileDataLoading extends GetFileDataState {}

class GetFileDataSuccess extends GetFileDataState {
  final List<GetFileDataModel> data;

  GetFileDataSuccess({required this.data});
}

class GetFileDataFailure extends GetFileDataState {
  final String errorMessage;

  GetFileDataFailure({required this.errorMessage});
}
