import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../routing/all_routes_imports.dart';

mixin LoginInterceptorHelpers {
  bool isRefreshing = false;
  bool loggedOut = false;
  final List<QueuedRequest> queue = [];

  bool isAuthPath(String path) =>
      path.contains(EndPoints.login) || path.contains(EndPoints.refreshToken);

  Future<bool> refreshToken() async {
    final token = LoginStorage.token;
    final rToken = LoginStorage.refreshToken;
    if (token == null || rToken == null) return false;
    try {
      final res = await ApiClient.refreshDio.post(
        EndPoints.refreshToken,
        data: {"token": token, "refreshToken": rToken},
      );
      if (res.statusCode != 200) return false;

      final responseData = res.data;
      if (responseData['isSuccess'] == false) return false;

      final data = responseData['data'] ?? responseData;

      final newToken = data['token'];
      final newRefreshToken = data['refreshToken'];

      if (newToken == null || newRefreshToken == null) return false;

      LoginStorage.setSession(
        tokenValue: newToken,
        refreshTokenValue: newRefreshToken,
        refreshTokenExpirationValue: data['refreshTokenExpiration'] != null
            ? DateTime.tryParse(data['refreshTokenExpiration'].toString()) ??
                  LoginStorage.refreshTokenExpiration ??
                  DateTime.now().add(const Duration(days: 7))
            : LoginStorage.refreshTokenExpiration ??
                  DateTime.now().add(const Duration(days: 7)),
      );
      await LoginStorage.savePersistent();
      return true;
    } catch (e) {
      debugPrint("Token Refresh Error: $e");
      return false;
    }
  }

  Future<Response> retry(RequestOptions req) {
    final token = LoginStorage.token;
    return ApiClient.dio.request(
      req.path,
      data: req.data,
      queryParameters: req.queryParameters,
      options: Options(
        method: req.method,
        headers: {
          ...req.headers,
          if (token != null) 'Authorization': 'Bearer $token',
        },
        contentType: req.contentType,
        responseType: req.responseType,
      ),
    );
  }

  void failAllQueued(DioException err) {
    for (final q in queue) {
      if (!q.completer.isCompleted) {
        q.completer.completeError(
          DioException(
            requestOptions: q.options,
            message: 'Session expired',
            type: DioExceptionType.cancel,
          ),
        );
      }
    }
    queue.clear();
  }

  void logout() {
    loggedOut = true;
    LoginStorage.clear();
    SessionDialog.showSessionExpired();
  }
}
