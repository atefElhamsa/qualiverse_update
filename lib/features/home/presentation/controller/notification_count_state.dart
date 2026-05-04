abstract class NotificationCountState {}

class NotificationCountInitial extends NotificationCountState {}
class NotificationCountLoading extends NotificationCountState {}
class NotificationCountSuccess extends NotificationCountState {
  final int count;
  NotificationCountSuccess(this.count);
}
class NotificationCountError extends NotificationCountState {
  final String message;
  NotificationCountError(this.message);
}