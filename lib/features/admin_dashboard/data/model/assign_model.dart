import '../../../../core/all_core_imports/all_core_imports.dart';

class AssignModel {
  final String? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  AssignModel({this.data, required this.isSuccess, this.error});

  factory AssignModel.fromJson(Map<String, dynamic> json) {
    return AssignModel(
      data: json['data'],
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}
