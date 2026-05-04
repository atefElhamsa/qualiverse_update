import 'package:qualiverse/core/errors/api_error_model.dart';

class NotificationModel {
  final int id;
  final String title;
  final String message;
  final String type;
  final bool isRead;
  final int? referenceId;
  final String createdOn;
  final String timeAgo;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.isRead,
    this.referenceId,
    required this.createdOn,
    required this.timeAgo,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json['id'] ?? 0,
        title: json['title'] ?? '',
        message: json['message'] ?? '',
        type: json['type'] ?? '',
        isRead: json['isRead'] ?? false,
        referenceId: json['referenceId'],
        createdOn: json['createdOn'] ?? '',
        timeAgo: json['timeAgo'] ?? '',
      );
}

class NotificationsResponseModel {
  final bool isSuccess;
  final List<NotificationModel>? data;
  final ApiErrorModel? error;

  NotificationsResponseModel({
    required this.isSuccess,
    required this.data,
    this.error,
  });

  factory NotificationsResponseModel.fromJson(Map<String, dynamic> json) =>
      NotificationsResponseModel(
        isSuccess: json['isSuccess'] ?? false,
        data: json['data'] != null
            ? List<NotificationModel>.from(
                json['data'].map((x) => NotificationModel.fromJson(x)),
              )
            : [],
        error: json['error'] is ApiErrorModel ? json['error'] : null,
      );
}

class GeneralNotificationResponseModel {
  final bool isSuccess;
  final String? data;
  final ApiErrorModel? error;

  GeneralNotificationResponseModel({
    required this.isSuccess,
    this.data,
    this.error,
  });

  factory GeneralNotificationResponseModel.fromJson(Map<String, dynamic> json) =>
      GeneralNotificationResponseModel(
        isSuccess: json['isSuccess'] ?? false,
        data: json['data']?.toString(),
        error: json['error'] != null
            ? ApiErrorModel.fromJson(json['error'])
            : null,
      );
}
