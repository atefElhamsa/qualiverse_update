import 'package:dio/dio.dart';

mixin ServiceErrorHandler {
  Never handleError(Object e) {
    if (e is DioException) {
      if (e.response?.statusCode == 401) throw Exception('Unauthorized');
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw Exception('No Internet Connection');
      }
      throw Exception(
        e.response?.data?['message'] ??
            e.response?.data?['error'] ??
            'Server Error',
      );
    }
    throw Exception(e.toString().replaceFirst('Exception: ', '').trim());
  }
}
