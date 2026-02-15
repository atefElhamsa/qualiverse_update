import 'dart:async';

import 'package:dio/dio.dart';

import '../../../../routing/all_routes_imports.dart';

class LoginInterceptor extends Interceptor {
  // =============================
  // Singleton
  // =============================
  static final LoginInterceptor _instance = LoginInterceptor._internal();
  factory LoginInterceptor() => _instance;
  LoginInterceptor._internal();

  bool _isRefreshing = false;
  bool _loggedOut = false;

  final List<QueuedRequest> _queue = [];

  // بعد Login
  void reset() {
    _loggedOut = false;
  }

  bool isAuthPath(String path) {
    return path.contains(EndPoints.login) ||
        path.contains(EndPoints.refreshToken);
  }

  // =============================
  // ON REQUEST
  // =============================
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // متحطش Authorization على login / refresh
    if (isAuthPath(options.path)) {
      handler.next(options);
      return;
    }

    // ضيف التوكن لو موجود
    final token = LoginStorage.token;
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  // =============================
  // ON ERROR (401)
  // =============================
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // تجاهل أي حالة غير 401
    if (_loggedOut ||
        err.response?.statusCode != 401 ||
        isAuthPath(err.requestOptions.path)) {
      handler.next(err);
      return;
    }

    // لو refresh شغال → استنى
    if (_isRefreshing) {
      final completer = Completer<Response>();
      _queue.add(QueuedRequest(err.requestOptions, completer));

      completer.future
          .then(handler.resolve)
          .catchError((_) => handler.next(err));
      return;
    }

    // =============================
    // حاول تعمل Refresh
    // =============================
    _isRefreshing = true;
    final refreshed = await refreshToken();
    _isRefreshing = false;

    // فشل refresh = انتهت الجلسة
    if (!refreshed) {
      _forceLogout();
      handler.next(err);
      return;
    }

    // =============================
    // إعادة الطلبات اللي كانت مستنية
    // =============================
    for (final q in _queue) {
      try {
        q.completer.complete(await _retry(q.options));
      } catch (e) {
        q.completer.completeError(e);
      }
    }
    _queue.clear();

    // =============================
    // إعادة الطلب الحالي
    // =============================
    try {
      handler.resolve(await _retry(err.requestOptions));
    } catch (_) {
      handler.next(err);
    }
  }

  // =============================
  // REFRESH TOKEN
  // =============================
  Future<bool> refreshToken() async {
    // هنا بس نفحص expiration
    if (LoginStorage.isRefreshTokenExpired) return false;

    final token = LoginStorage.token;
    final refreshToken = LoginStorage.refreshToken;

    if (token == null || refreshToken == null) return false;

    try {
      final res = await ApiClient.refreshDio.post(
        EndPoints.refreshToken,
        data: {'token': token, 'refreshToken': refreshToken},
      );

      if (res.statusCode == 200) {
        final responseData = res.data;

        if (responseData['isSuccess'] != true) {
          return false;
        }

        final data = responseData['data'];

        LoginStorage.setSession(
          tokenValue: data['token'],
          refreshTokenValue: data['refreshToken'],
          refreshTokenExpirationValue: DateTime.parse(
            data['refreshTokenExpiration'],
          ),
        );

        await LoginStorage.savePersistent();
        return true;
      }

      return false;
    } catch (_) {
      return false;
    }
  }

  // =============================
  // RETRY REQUEST
  // =============================
  Future<Response> _retry(RequestOptions req) {
    final token = LoginStorage.token;

    final options = Options(
      method: req.method,
      headers: {
        ...req.headers,
        if (token != null) 'Authorization': 'Bearer $token',
      },
      contentType: req.contentType,
      responseType: req.responseType,
      followRedirects: req.followRedirects,
      receiveTimeout: req.receiveTimeout,
      sendTimeout: req.sendTimeout,
    );

    return ApiClient.dio.request(
      req.path,
      data: req.data,
      queryParameters: req.queryParameters,
      options: options,
    );
  }

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
// QUEUED REQUEST MODEL
// =============================
class QueuedRequest {
  final RequestOptions options;
  final Completer<Response> completer;

  QueuedRequest(this.options, this.completer);
}
