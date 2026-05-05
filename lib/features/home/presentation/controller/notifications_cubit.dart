import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/home/presentation/controller/notifications_state.dart';
import '../../data/models/notification_model.dart';
import '../../data/service/notifications_service.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial());

  int currentPage = 1;
  final int pageSize = 5;
  List<NotificationModel> allNotifications = [];
  bool hasMore = true;
  bool? currentIsReadFilter;

  Future<void> getRecentNotifications() async {
    emit(NotificationsLoading());
    final result = await NotificationsService.getNotifications(
      pageIndex: 1,
      pageSize: 5,
    );
    if (result.isSuccess) {
      emit(
        NotificationsSuccess(notifications: result.data ?? [], hasMore: true),
      );
    } else {
      emit(NotificationsError(result.error?.description ?? "Error"));
    }
  }

  Future<void> getAllNotifications({
    bool loadMore = false,
    bool? isRead,
  }) async {
    if (loadMore) {
      if (!hasMore) return;
      currentPage++;
      emit(NotificationsPaginationLoading());
    } else {
      currentPage = 1;
      allNotifications.clear();
      hasMore = true;
      currentIsReadFilter = isRead;
      emit(NotificationsLoading());
    }

    final result = await NotificationsService.getNotifications(
      pageIndex: currentPage,
      pageSize: pageSize,
      isRead: currentIsReadFilter,
    );

    if (result.isSuccess) {
      final List<NotificationModel> newData = result.data ?? [];
      if (newData.length < pageSize) {
        hasMore = false;
      }
      allNotifications.addAll(newData);
      emit(
        NotificationsSuccess(
          notifications: List.from(allNotifications),
          hasMore: hasMore,
        ),
      );
    } else {
      emit(NotificationsError(result.error?.description ?? "Error"));
    }
  }

  Future<void> deleteNotification({required int id}) async {
    emit(NotificationActionLoading());
    final result = await NotificationsService.deleteNotification(id: id);
    if (result.isSuccess) {
      allNotifications.removeWhere((n) => n.id == id);
      emit(NotificationActionSuccess("Notification deleted successfully"));
      emit(
        NotificationsSuccess(
          notifications: List.from(allNotifications),
          hasMore: hasMore,
        ),
      );
    } else {
      emit(
        NotificationActionError(
          result.error?.description ?? "Failed to delete notification",
        ),
      );
    }
  }

  Future<void> markAsRead({required int id}) async {
    emit(NotificationActionLoading());
    final result = await NotificationsService.markAsRead(id: id);
    if (result.isSuccess) {
      final index = allNotifications.indexWhere((n) => n.id == id);
      if (index != -1) {
        final oldNotif = allNotifications[index];
        allNotifications[index] = NotificationModel(
          id: oldNotif.id,
          title: oldNotif.title,
          message: oldNotif.message,
          type: oldNotif.type,
          isRead: true,
          referenceId: oldNotif.referenceId,
          createdOn: oldNotif.createdOn,
          timeAgo: oldNotif.timeAgo,
        );
      }
      emit(NotificationActionSuccess("Notification marked as read"));
      emit(
        NotificationsSuccess(
          notifications: List.from(allNotifications),
          hasMore: hasMore,
        ),
      );
    } else {
      emit(
        NotificationActionError(
          result.error?.description ?? "Failed to mark notification as read",
        ),
      );
    }
  }

  Future<void> markAllAsRead() async {
    emit(NotificationActionLoading());
    final result = await NotificationsService.markAllAsRead();
    if (result.isSuccess) {
      allNotifications = allNotifications.map((n) {
        return NotificationModel(
          id: n.id,
          title: n.title,
          message: n.message,
          type: n.type,
          isRead: true,
          referenceId: n.referenceId,
          createdOn: n.createdOn,
          timeAgo: n.timeAgo,
        );
      }).toList();
      emit(NotificationActionSuccess("All notifications marked as read"));
      emit(
        NotificationsSuccess(
          notifications: List.from(allNotifications),
          hasMore: hasMore,
        ),
      );
    } else {
      emit(
        NotificationActionError(
          result.error?.description ?? "Failed to mark all as read",
        ),
      );
    }
  }

  Future<void> cleanupNotifications({int daysRetention = 30}) async {
    emit(NotificationActionLoading());
    final result = await NotificationsService.cleanupNotifications(
      daysRetention: daysRetention,
    );
    if (result.isSuccess) {
      emit(NotificationActionSuccess("Old notifications cleaned up successfully"));
      // Refresh the list
      getAllNotifications();
    } else {
      emit(
        NotificationActionError(
          result.error?.description ?? "Failed to cleanup notifications",
        ),
      );
    }
  }
}
