import 'dart:async';

import 'package:dio/dio.dart';

import '../../../../routing/all_routes_imports.dart';

class LoginInterceptor extends Interceptor {
  bool _isRefreshing = false;
  bool _loggedOut = false;

  final List<QueuedRequest> _queue = [];

  bool isAuthPath(String path) {
    return path.contains(EndPoints.login) ||
        path.contains(EndPoints.refreshToken);
  }

  // =============================
  // ADD ACCESS TOKEN
  // =============================
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!isAuthPath(options.path)) {
      final token = LoginStorage.token;
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    handler.next(options);
  }

  // =============================
  // HANDLE 401
  // =============================
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_loggedOut ||
        err.response?.statusCode != 401 ||
        isAuthPath(err.requestOptions.path)) {
      return handler.next(err);
    }

    // لو refresh شغال → نخزن الطلب
    if (_isRefreshing) {
      final completer = Completer<Response>();
      _queue.add(QueuedRequest(err.requestOptions, completer));

      completer.future
          .then(handler.resolve)
          .catchError((_) => handler.next(err));
      return;
    }

    // نبدأ refresh
    _isRefreshing = true;
    final refreshed = await refreshToken();
    _isRefreshing = false;

    // refreshTokenExpiration خلص
    if (!refreshed) {
      _forceLogout();
      return;
    }

    // إعادة الطلبات اللي كانت مستنية
    for (final q in _queue) {
      try {
        q.completer.complete(await retry(q.options));
      } catch (e) {
        q.completer.completeError(e);
      }
    }
    _queue.clear();

    // إعادة الطلب الحالي
    try {
      handler.resolve(await retry(err.requestOptions));
    } catch (e) {
      handler.next(err);
    }
  }

  // =============================
  // REFRESH TOKEN
  // =============================
  Future<bool> refreshToken() async {
    try {
      final refreshToken = LoginStorage.refreshToken;
      if (refreshToken == null || refreshToken.isEmpty) {
        return false;
      }

      final res = await ApiClient.refreshDio.post(
        EndPoints.refreshToken,
        data: {'refreshToken': refreshToken},
      );

      // لسه صالح
      if (res.statusCode == 200) {
        LoginStorage.setSession(
          tokenValue: res.data['token'],
          refreshTokenValue: res.data['refreshToken'],
        );
        await LoginStorage.savePersistent();
        return true;
      }

      // أي status غير 200 = refresh انتهى
      return false;
    } on DioException catch (e) {
      // refreshTokenExpiration خلص
      if (e.response?.statusCode == 401 || e.response?.statusCode == 403) {
        return false;
      }
      return false;
    }
  }

  // =============================
  // RETRY REQUEST
  // =============================

  Future<Response> retry(RequestOptions req) {
    final token = LoginStorage.token;

    req.headers['Authorization'] = 'Bearer $token';
    return ApiClient.dio.fetch(req);
  }

  // Future<Response> retry(RequestOptions req) {
  //   final token = LoginStorage.token;
  //
  //   return ApiClient.dio.request(
  //     req.path,
  //     data: req.data,
  //     queryParameters: req.queryParameters,
  //     options: Options(
  //       method: req.method,
  //       headers: {...req.headers, 'Authorization': 'Bearer $token'},
  //     ),
  //   );
  // }

  // =============================
  // FORCE LOGOUT
  // =============================
  void _forceLogout() {
    if (_loggedOut) return;
    _loggedOut = true;

    _queue.clear();
    LoginStorage.clear();
    SessionDialog.showSessionExpired();
  }
}

// =============================
// QUEUE MODEL
// =============================
class QueuedRequest {
  final RequestOptions options;
  final Completer<Response> completer;

  QueuedRequest(this.options, this.completer);
}
