import 'package:qualiverse/features/edit_files/data/models/get_file_data_model.dart';

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
