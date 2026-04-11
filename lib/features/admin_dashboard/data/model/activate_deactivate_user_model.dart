import 'package:qualiverse/routing/all_routes_imports.dart';

class ActivateDeactivateUserModel {
  final bool isSuccess;
  final String? data;
  final ApiErrorModel? error;

  ActivateDeactivateUserModel({required this.isSuccess, this.data, this.error});

  factory ActivateDeactivateUserModel.fromJson(Map<String, dynamic> json) {
    return ActivateDeactivateUserModel(
      isSuccess: json['isSuccess'],
      data: json['data'],
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}
