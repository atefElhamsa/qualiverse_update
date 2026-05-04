import '../../../../core/errors/api_error_model.dart';

class UnreadNotificationModel {
  final bool isSuccess;
  final int? data;
  final ApiErrorModel? error;

  UnreadNotificationModel({
    required this.isSuccess,
    this.data,
    this.error,
  });

  factory UnreadNotificationModel.fromJson(Map<String, dynamic> json) =>
      UnreadNotificationModel(
        isSuccess: json['isSuccess'] ?? false,
        data: json['data'],
        error: json['error'] != null
            ? ApiErrorModel.fromJson(json['error'])
            : null,
      );
}