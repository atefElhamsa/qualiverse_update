import 'package:qualiverse/routing/all_routes_imports.dart';

class AssignmentIndicatorAdminResponseModel {
  final List<AssignmentIndicatorAdminModel>? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  AssignmentIndicatorAdminResponseModel({
    required this.data,
    required this.isSuccess,
    required this.error,
  });

  factory AssignmentIndicatorAdminResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return AssignmentIndicatorAdminResponseModel(
      data: json['data'] != null
          ? (json['data'] as List)
                .map((x) => AssignmentIndicatorAdminModel.fromJson(x))
                .toList()
          : null,
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class AssignmentIndicatorAdminModel {
  final int id;
  final int indicatorId;
  final String indicatorName;
  final String description;
  final String doctorId;
  final String doctorName;
  final DateTime? deadline;
  final String status;
  final String filePath;

  AssignmentIndicatorAdminModel({
    required this.id,
    required this.indicatorId,
    required this.indicatorName,
    required this.description,
    required this.doctorId,
    required this.doctorName,
    required this.deadline,
    required this.status,
    required this.filePath,
  });

  factory AssignmentIndicatorAdminModel.fromJson(Map<String, dynamic> json) {
    return AssignmentIndicatorAdminModel(
      id: json['id'] ?? 0,
      indicatorId: json['indicatorId'] ?? 0,
      indicatorName: json['indicatorName'] ?? '',
      description: json['description'] ?? '',
      doctorId: json['doctorId'] ?? '',
      doctorName: json['doctorName'] ?? '',
      deadline: json['deadline'] != null
          ? DateTime.tryParse(json['deadline'])
          : null,
      status: json['status'] ?? '',
      filePath: json['filePath'] ?? '',
    );
  }
}
