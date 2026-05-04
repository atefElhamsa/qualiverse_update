import 'package:qualiverse/features/home/data/models/notification_model.dart';

abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}
class NotificationsLoading extends NotificationsState {}
class NotificationsPaginationLoading extends NotificationsState {}
class NotificationsSuccess extends NotificationsState {
  final List<NotificationModel> notifications;
  final bool hasMore;
  NotificationsSuccess({required this.notifications, this.hasMore = true});
}
class NotificationsError extends NotificationsState {
  final String message;
  NotificationsError(this.message);
}

class NotificationActionLoading extends NotificationsState {}

class NotificationActionSuccess extends NotificationsState {
  final String message;
  NotificationActionSuccess(this.message);
}

class NotificationActionError extends NotificationsState {
  final String message;
  NotificationActionError(this.message);
}