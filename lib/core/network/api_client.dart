import 'package:dio/dio.dart';

import '../../routing/all_routes_imports.dart';

class ApiClient {
  static BaseOptions baseOptions() => BaseOptions(
    baseUrl: EndPoints.baseUrl,
    connectTimeout: const Duration(seconds: 15),
    receiveTimeout: const Duration(seconds: 15),
    headers: {"Accept": "application/json", "Content-Type": "application/json"},
  );

  static final Dio refreshDio = Dio(baseOptions());

  static final Dio dio = Dio(baseOptions())
    ..interceptors.addAll([LoginInterceptor(), LanguageInterceptor()]);
}
