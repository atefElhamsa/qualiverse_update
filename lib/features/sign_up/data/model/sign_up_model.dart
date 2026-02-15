import '../../../../core/all_core_imports/all_core_imports.dart';

class SignUpModel {
  final String? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  SignUpModel({this.data, required this.isSuccess, this.error});

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    return SignUpModel(
      data: json['data'],
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}
