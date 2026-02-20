import 'package:qualiverse/routing/all_routes_imports.dart';

class LogoutResponse {
  final bool isSuccess;
  final String? data;
  final ApiErrorModel? error;

  LogoutResponse({required this.isSuccess, this.data, this.error});

  factory LogoutResponse.fromJson(Map<String, dynamic> json) {
    return LogoutResponse(
      isSuccess: json['isSuccess'] ?? false,
      data: json['data'],
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}
