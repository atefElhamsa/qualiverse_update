import 'package:qualiverse/core/errors/api_error_model.dart';

class ApproveRejectAssignmentResponseModel {
  final String? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  ApproveRejectAssignmentResponseModel({
    this.data,
    required this.isSuccess,
    this.error,
  });

  factory ApproveRejectAssignmentResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ApproveRejectAssignmentResponseModel(
      data: json['data'],
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}
