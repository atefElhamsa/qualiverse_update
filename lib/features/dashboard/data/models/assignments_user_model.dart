import 'package:qualiverse/routing/all_routes_imports.dart';

class AssignmentsUserModel {
  final List<AssignmentData>? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  AssignmentsUserModel({this.data, required this.isSuccess, this.error});

  factory AssignmentsUserModel.fromJson(Map<String, dynamic> json) {
    return AssignmentsUserModel(
      data: json['data'] != null
          ? (json['data'] as List)
                .map((e) => AssignmentData.fromJson(e))
                .toList()
          : null,
      isSuccess: json['isSuccess'],
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class AssignmentData {
  final int id;
  final int indicatorId;
  final int criterionId;
  final String indicatorName;
  final String description;
  final DateTime deadline;
  final String status;
  final int daysRemaining;
  final bool isOverdue;

  AssignmentData({
    required this.id,
    required this.indicatorId,
    required this.criterionId,
    required this.indicatorName,
    required this.description,
    required this.deadline,
    required this.status,
    required this.daysRemaining,
    required this.isOverdue,
  });

  factory AssignmentData.fromJson(Map<String, dynamic> json) {
    return AssignmentData(
      id: json['id'],
      indicatorId: json['indicatorId'],
      criterionId: json['criterionId'] ?? 0,
      indicatorName: json['indicatorName'],
      description: json['description'],
      deadline: DateTime.parse(json['deadline']),
      status: json['status'],
      daysRemaining: json['daysRemaining'],
      isOverdue: json['isOverdue'],
    );
  }
}
