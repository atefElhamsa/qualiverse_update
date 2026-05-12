import 'package:qualiverse/routing/all_routes_imports.dart';

class AiGenerationStatusModel {
  final AiGenerationStatusData? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  AiGenerationStatusModel({this.data, required this.isSuccess, this.error});

  factory AiGenerationStatusModel.fromJson(Map<String, dynamic> json) {
    return AiGenerationStatusModel(
      data: json['data'] != null
          ? AiGenerationStatusData.fromJson(json['data'])
          : null,
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null && json['error'] is Map
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class AiGenerationStatusData {
  final String id;
  final String sessionId;
  final String status;
  final String? error;

  AiGenerationStatusData({
    required this.id,
    required this.sessionId,
    required this.status,
    this.error,
  });

  factory AiGenerationStatusData.fromJson(Map<String, dynamic> json) {
    return AiGenerationStatusData(
      id: json['id'],
      sessionId: json['sessionId'],
      status: json['status'],
      error: json['error'],
    );
  }
}
