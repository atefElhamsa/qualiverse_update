import 'package:qualiverse/routing/all_routes_imports.dart';

class ChangePasswordModel {
  final bool isSuccess;
  final String? data;
  final ApiErrorModel? error;

  ChangePasswordModel({required this.isSuccess, this.data, this.error});

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordModel(
      isSuccess: json['isSuccess'],
      data: json['data'],
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}
