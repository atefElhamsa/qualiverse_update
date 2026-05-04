import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/home/presentation/controller/notification_count_state.dart';
import '../../data/service/unread_notification_service.dart';

class NotificationCountCubit extends Cubit<NotificationCountState> {
  NotificationCountCubit() : super(NotificationCountInitial());

  Future<void> getUnreadCount() async {
    emit(NotificationCountLoading());
    final result = await UnreadNotificationService.getUnreadCount();
    if (result.isSuccess) {
      emit(NotificationCountSuccess(result.data ?? 0));
    } else {
      emit(NotificationCountError(result.error?.description ?? "Error"));
    }
  }
}
