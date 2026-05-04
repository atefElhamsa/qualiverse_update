import 'package:dio/dio.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import '../models/notification_model.dart';

class NotificationsService {
  static final Dio dio = ApiClient.dio;

  static Future<NotificationsResponseModel> getNotifications({
    required int pageIndex,
    required int pageSize,
    bool? isRead,
  }) async {
    try {
      final response = await dio.get(
        EndPoints.getAllNotifications(
          pageIndex: pageIndex,
          pageSize: pageSize,
          isRead: isRead,
        ),
      );
      return NotificationsResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      return NotificationsResponseModel(
        isSuccess: false,
        data: [],
        error: ApiErrorModel(
          code: '',
          description: e.message ?? "Failed to fetch notifications",
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    } catch (e) {
      return NotificationsResponseModel(
        isSuccess: false,
        data: [],
        error: ApiErrorModel(
          code: '',
          description: e.toString(),
          statusCode: 500,
        ),
      );
    }
  }

  static Future<GeneralNotificationResponseModel> deleteNotification({
    required int id,
  }) async {
    try {
      final response = await dio.delete(EndPoints.deleteNotification(id: id));
      return GeneralNotificationResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      return GeneralNotificationResponseModel(
        isSuccess: false,
        error: ApiErrorModel(
          code: '',
          description: e.message ?? "Failed to delete notification",
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    } catch (e) {
      return GeneralNotificationResponseModel(
        isSuccess: false,
        error: ApiErrorModel(
          code: '',
          description: e.toString(),
          statusCode: 500,
        ),
      );
    }
  }

  static Future<GeneralNotificationResponseModel> markAsRead({
    required int id,
  }) async {
    try {
      final response = await dio.put(EndPoints.markNotificationAsRead(id: id));
      return GeneralNotificationResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      return GeneralNotificationResponseModel(
        isSuccess: false,
        error: ApiErrorModel(
          code: '',
          description: e.message ?? "Failed to mark notification as read",
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    } catch (e) {
      return GeneralNotificationResponseModel(
        isSuccess: false,
        error: ApiErrorModel(
          code: '',
          description: e.toString(),
          statusCode: 500,
        ),
      );
    }
  }

  static Future<GeneralNotificationResponseModel> markAllAsRead() async {
    try {
      final response = await dio.put(EndPoints.markAllNotificationsAsRead());
      return GeneralNotificationResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      return GeneralNotificationResponseModel(
        isSuccess: false,
        error: ApiErrorModel(
          code: '',
          description: e.message ?? "Failed to mark all notifications as read",
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    } catch (e) {
      return GeneralNotificationResponseModel(
        isSuccess: false,
        error: ApiErrorModel(
          code: '',
          description: e.toString(),
          statusCode: 500,
        ),
      );
    }
  }
}
