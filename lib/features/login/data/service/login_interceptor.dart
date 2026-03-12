import 'dart:async';

import 'package:dio/dio.dart';

import '../../../../routing/all_routes_imports.dart';

class LoginInterceptor extends Interceptor {
  static final LoginInterceptor instance = LoginInterceptor.internal();

  factory LoginInterceptor() => instance;

  LoginInterceptor.internal();

  bool isRefreshing = false;
  bool loggedOut = false;
  final List<QueuedRequest> queue = [];

  bool isAuthPath(String path) {
    return path.contains(EndPoints.login) ||
        path.contains(EndPoints.refreshToken);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (isAuthPath(options.path)) {
      handler.next(options);
      return;
    }

    // ===========================
    // Auto-refresh if token about to expire
    // ===========================
    if (LoginStorage.tokenExpiresSoon) {
      if (!isRefreshing) {
        isRefreshing = true;
        final refreshed = await refreshToken();
        isRefreshing = false;

        if (!refreshed) {
          logout();
          handler.reject(
            DioException(
              requestOptions: options,
              message: "Session expired",
              type: DioExceptionType.cancel,
            ),
          );
          return;
        }

        // Retry queued requests
        for (final q in queue) {
          try {
            final res = await retry(q.options);
            q.completer.complete(res);
          } catch (e) {
            q.completer.completeError(e);
          }
        }
        queue.clear();
      } else {
        // Refresh running → queue this request
        final completer = Completer<Response>();
        queue.add(QueuedRequest(options, completer));
        try {
          final response = await completer.future;
          handler.resolve(response);
        } catch (_) {
          handler.reject(
            DioException(
              requestOptions: options,
              message: "Session expired",
              type: DioExceptionType.cancel,
            ),
          );
        }
        return;
      }
    }

    final token = LoginStorage.token;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (loggedOut || isAuthPath(err.requestOptions.path)) {
      handler.next(err);
      return;
    }

    if (err.response?.statusCode == 401 || err.response?.statusCode == 403) {
      if (isRefreshing) {
        final completer = Completer<Response>();
        queue.add(QueuedRequest(err.requestOptions, completer));
        try {
          final response = await completer.future;
          handler.resolve(response);
        } catch (_) {
          handler.next(err);
        }
        return;
      }

      isRefreshing = true;
      final refreshed = await refreshToken();
      isRefreshing = false;

      if (!refreshed) {
        failAllQueued(err);
        logout();
        handler.next(err);
        return;
      }

      // Retry queued requests
      for (final q in queue) {
        try {
          final res = await retry(q.options);
          q.completer.complete(res);
        } catch (e) {
          q.completer.completeError(e);
        }
      }
      queue.clear();

      // Retry original request
      try {
        final response = await retry(err.requestOptions);
        handler.resolve(response);
      } catch (_) {
        handler.next(err);
      }
      return;
    }

    handler.next(err); // Any other error
  }

  Future<bool> refreshToken() async {
    final token = LoginStorage.token;
    final refreshToken = LoginStorage.refreshToken;

    if (token == null || refreshToken == null) return false;

    try {
      final res = await ApiClient.refreshDio.post(
        EndPoints.refreshToken,
        data: {"token": token, "refreshToken": refreshToken},
      );

      if (res.statusCode != 200 || res.data['isSuccess'] != true) return false;

      final data = res.data['data'];

      LoginStorage.setSession(
        tokenValue: data['token'],
        refreshTokenValue: data['refreshToken'],
        refreshTokenExpirationValue: DateTime.parse(
          data['refreshTokenExpiration'],
        ),
      );

      await LoginStorage.savePersistent();

      return true;
    } catch (_) {
      return false;
    }
  }

  Future<Response> retry(RequestOptions req) {
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

class QueuedRequest {
  final RequestOptions options;
  final Completer<Response> completer;

  QueuedRequest(this.options, this.completer);
}

// ============================================
// LoginStorage Extension - tokenExpiresSoon
// ============================================
extension LoginStorageExtension on LoginStorage {
  static bool get tokenExpiresSoon {
    if (LoginStorage.refreshTokenExpiration == null) return false;
    final now = DateTime.now();
    return LoginStorage.refreshTokenExpiration!.isBefore(
      now.add(const Duration(seconds: 60)),
    );
  }
}
