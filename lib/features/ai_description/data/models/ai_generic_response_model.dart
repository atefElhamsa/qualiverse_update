import 'package:qualiverse/routing/all_routes_imports.dart';

class AiGenericResponseModel {
  final String? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  AiGenericResponseModel({this.data, required this.isSuccess, this.error});

  factory AiGenericResponseModel.fromJson(Map<String, dynamic> json) {
    return AiGenericResponseModel(
      data: json['data'] is String ? json['data'] : json['data']?.toString(),
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null ? ApiErrorModel.fromJson(json['error']) : null,
    );
  }
}
