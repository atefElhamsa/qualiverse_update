import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../../routing/all_routes_imports.dart';

class LoginInterceptor extends Interceptor {
  static final LoginInterceptor instance = LoginInterceptor.internal();
  factory LoginInterceptor() => instance;
  LoginInterceptor.internal();

  bool loggedOut = false;

  /// 🔥 Single refresh lock (THE CORE FIX)
  Completer<void>? _refreshCompleter;

  Future<void> forceRefreshToken() async {
    if (!LoginStorage.hasToken) return;

    if (_refreshCompleter != null) {
      return _refreshCompleter!.future;
    }

    _refreshCompleter = Completer<void>();

    try {
      final success = await _refreshToken();

      if (!success) {
        _refreshCompleter!.completeError("SESSION_EXPIRED");
        _logout();
        return;
      }

      _refreshCompleter!.complete();
    } catch (e) {
      _refreshCompleter!.completeError(e);
      // We don't rethrow here to avoid crashing if called standalone
    } finally {
      _refreshCompleter = null;
    }
  }

  bool isAuthPath(String path) {
    return path.contains(EndPoints.login) ||
        path.contains(EndPoints.refreshToken);
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (isAuthPath(options.path)) {
      handler.next(options);
      return;
    }

    try {
      await _ensureTokenValid();
    } catch (_) {
      handler.reject(
        DioException(requestOptions: options, error: "SESSION_EXPIRED"),
      );
      return;
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

    if (err.response?.statusCode == 401) {
      try {
        await _ensureTokenValid();

        final response = await _retry(err.requestOptions);
        handler.resolve(response);
        return;
      } on DioException catch (e) {
        // لو الـ retry فشل بسبب network error → مش logout، بس fail الـ request
        if (e.response == null ||
            e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          handler.next(err);
          return;
        }
        // لو فشل بسبب auth failure حقيقية (4xx) → logout
        _logout();
        handler.next(err);
        return;
      } catch (_) {
        // أي error تاني غير DioException → logout
        _logout();
        handler.next(err);
        return;
      }
    }

    handler.next(err);
  }

  /// ==============================
  /// 🔥 CORE REFRESH CONTROLLER
  /// ==============================
  Future<void> _ensureTokenValid() async {
    if (!LoginStorage.hasToken) return;

    /// لو refresh شغال بالفعل → نستنى نفس النتيجة
    if (_refreshCompleter != null) {
      return _refreshCompleter!.future;
    }

    /// لو التوكن مش محتاج refresh → نكمل عادي
    if (!LoginStorage.accessTokenExpiresSoon) return;

    _refreshCompleter = Completer<void>();

    try {
      final success = await _refreshToken();

      if (!success) {
        _refreshCompleter!.completeError("SESSION_EXPIRED");
        _logout();
        return;
      }

      _refreshCompleter!.complete();
    } catch (e) {
      _refreshCompleter!.completeError(e);
      rethrow;
    } finally {
      _refreshCompleter = null;
    }
  }

  /// ==============================
  /// 🔥 ACTUAL REFRESH CALL
  /// ==============================
  Future<bool> _refreshToken() async {
    final token = LoginStorage.token;
    final refreshToken = LoginStorage.refreshToken;

    if (token == null || refreshToken == null) return false;

    debugPrint("================== REFRESH TOKEN STARTED ==================");
    debugPrint("OLD TOKEN: $token");
    debugPrint("OLD REFRESH TOKEN: $refreshToken");

    try {
      final res = await ApiClient.refreshDio.post(
        EndPoints.refreshToken,
        data: {"token": token, "refreshToken": refreshToken},
      );

      final data = res.data['data'] ?? res.data;

      final newToken = data['token'];
      final newRefreshToken = data['refreshToken'];

      debugPrint("NEW TOKEN: $newToken");
      debugPrint("NEW REFRESH TOKEN: $newRefreshToken");
      debugPrint("===========================================================");

      if (newToken == null || newRefreshToken == null) return false;

      /// 🔥 update session atomically
      LoginStorage.setSession(
        tokenValue: newToken,
        refreshTokenValue: newRefreshToken,
        refreshTokenExpirationValue: data['refreshTokenExpiration'] != null
            ? DateTime.tryParse(data['refreshTokenExpiration'].toString()) ??
                  LoginStorage.refreshTokenExpiration ??
                  DateTime.now().add(const Duration(days: 7))
            : LoginStorage.refreshTokenExpiration ??
                  DateTime.now().add(const Duration(days: 7)),
        expiresInSeconds: data['expiresIn'] is int
            ? data['expiresIn']
            : int.tryParse(data['expiresIn']?.toString() ?? ''),
      );

      await LoginStorage.savePersistent();

      return true;
    } catch (e) {
      if (e is DioException &&
          e.response != null &&
          e.response!.statusCode! >= 400 &&
          e.response!.statusCode! < 500) {
        return false;
      }

      rethrow;
    }
  }

  /// ==============================
  /// 🔁 RETRY REQUEST
  /// ==============================
  Future<Response> _retry(RequestOptions req) {
    final token = LoginStorage.token;

    final options = Options(
      method: req.method,
      headers: {
        ...req.headers,
        if (token != null) 'Authorization': 'Bearer $token',
      },
      responseType: req.responseType,
      contentType: req.contentType,
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

  /// ==============================
  /// 🚪 LOGOUT
  /// ==============================
  void _logout() {
    if (loggedOut) return;

    loggedOut = true;
    LoginStorage.clear();
    SessionDialog.showSessionExpired();
  }
}
