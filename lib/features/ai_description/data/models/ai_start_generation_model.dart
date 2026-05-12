import 'package:qualiverse/routing/all_routes_imports.dart';

class AiStartGenerationModel {
  final AiStartGenerationData? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  AiStartGenerationModel({this.data, required this.isSuccess, this.error});

  factory AiStartGenerationModel.fromJson(Map<String, dynamic> json) {
    return AiStartGenerationModel(
      data: json['data'] != null
          ? AiStartGenerationData.fromJson(json['data'])
          : null,
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class AiStartGenerationData {
  final String id;
  final String status;
  final String? errorMessage;
  final String courseName;
  final DateTime createdAt;
  final DateTime updatedAt;

  AiStartGenerationData({
    required this.id,
    required this.status,
    this.errorMessage,
    required this.courseName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AiStartGenerationData.fromJson(Map<String, dynamic> json) {
    return AiStartGenerationData(
      id: json['id'],
      status: json['status'],
      errorMessage: json['errorMessage'],
      courseName: json['courseName'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
