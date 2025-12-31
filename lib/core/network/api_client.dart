import 'package:dio/dio.dart';

import '../../routing/all_routes_imports.dart';

class ApiClient {
  // Dio Refresh
  static final Dio refreshDio = Dio(
    BaseOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    ),
  );

  // Dio Main APIs
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: EndPoints.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
      },
    ),
  )..interceptors.add(LoginInterceptor());
}
