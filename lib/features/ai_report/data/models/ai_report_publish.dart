import 'package:qualiverse/routing/all_routes_imports.dart';

class AiReportPublishResponse {
  final bool isSuccess;
  final ApiErrorModel? error;

  AiReportPublishResponse({required this.isSuccess, this.error});

  factory AiReportPublishResponse.fromJson(Map<String, dynamic> json) {
    return AiReportPublishResponse(
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}
