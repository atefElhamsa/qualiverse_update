import '../../../../core/all_core_imports/all_core_imports.dart';

class ResetPasswordModel {
  final String? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  const ResetPasswordModel({this.data, required this.isSuccess, this.error});

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    return ResetPasswordModel(
      data: json['data'],
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}
