import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/home/presentation/controller/notification_count_state.dart';
import '../../data/service/unread_notification_service.dart';

class NotificationCountCubit extends Cubit<NotificationCountState> {
  NotificationCountCubit() : super(NotificationCountInitial());

  Timer? _timer;

  Future<void> getUnreadCount({bool isPolling = false}) async {
    if (!isPolling) emit(NotificationCountLoading());
    
    final result = await UnreadNotificationService.getUnreadCount();
    if (result.isSuccess) {
      emit(NotificationCountSuccess(result.data ?? 0));
    } else if (!isPolling) {
      emit(NotificationCountError(result.error?.description ?? "Error"));
    }
  }

  void startPolling() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      getUnreadCount(isPolling: true);
    });
  }

  void stopPolling() {
    _timer?.cancel();
  }

  void reset() {
    stopPolling();
    emit(NotificationCountInitial());
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
