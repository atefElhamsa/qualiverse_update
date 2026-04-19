import '../../../../core/all_core_imports/all_core_imports.dart';

class CycleIndicatorModelResponse {
  final List<CycleIndicatorModel>? cycleIndicators;
  final bool isSuccess;
  final ApiErrorModel? error;

  CycleIndicatorModelResponse({
    this.cycleIndicators,
    required this.isSuccess,
    this.error,
  });

  factory CycleIndicatorModelResponse.fromJson(Map<String, dynamic> json) {
    return CycleIndicatorModelResponse(
      cycleIndicators: (json['data'] as List)
          .map((e) => CycleIndicatorModel.fromJson(e))
          .toList(),
      isSuccess: json['isSuccess'],
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class CycleIndicatorModel {
  final int id;
  final int indicatorId;
  final String indicatorName;
  final String description;
  final String? doctorId;
  final String? doctorName;
  final DateTime? deadline;
  final String? status;

  CycleIndicatorModel({
    required this.id,
    required this.indicatorId,
    required this.indicatorName,
    required this.description,
    this.doctorId,
    this.doctorName,
    this.deadline,
    this.status,
  });

  factory CycleIndicatorModel.fromJson(Map<String, dynamic> json) {
    return CycleIndicatorModel(
      id: json['id'],
      indicatorId: json['indicatorId'],
      indicatorName: json['indicatorName'],
      description: json['description'],
      doctorId: json['doctorId'],
      doctorName: json['doctorName'],
      deadline: json['deadline'] != null
          ? DateTime.parse(json['deadline'])
          : null,
      status: json['status'],
    );
  }
}
