import 'package:dio/dio.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import '../models/unread_notification_model.dart';

class UnreadNotificationService {
  static final Dio dio = ApiClient.dio;

  static Future<UnreadNotificationModel> getUnreadCount() async {
    try {
      final response = await dio.get(EndPoints.unreadNotificationCount);
      return UnreadNotificationModel.fromJson(response.data);
    } on DioException catch (e) {
      return UnreadNotificationModel(
        isSuccess: false,
        error: ApiErrorModel(
          code: '',
          description: e.message ?? "Failed to fetch count",
          statusCode: e.response?.statusCode ?? 500,
        ),
      );
    } catch (e) {
      return UnreadNotificationModel(
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
