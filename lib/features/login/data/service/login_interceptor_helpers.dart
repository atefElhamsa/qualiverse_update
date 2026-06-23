import 'dart:async';
import 'package:dio/dio.dart';
import 'package:qualiverse/features/login/data/service/queued_request.dart';
import '../../../../routing/all_routes_imports.dart';

mixin LoginInterceptorHelpers {
  bool loggedOut = false;

  /// 🔥 Single refresh lock (FIX ALL RACE ISSUES)
  Completer<void>? _refreshCompleter;

  final List<QueuedRequest> queue = [];

  bool isAuthPath(String path) =>
      path.contains(EndPoints.login) || path.contains(EndPoints.refreshToken);

  // =========================
  // 🔥 CORE REFRESH LOGIC
  // =========================
  Future<void> ensureRefreshed() async {
    if (loggedOut) return;

    /// لو refresh شغال → استنى نفس النتيجة
    if (_refreshCompleter != null) {
      return _refreshCompleter!.future;
    }

    /// لو مفيش حاجة تحتاج refresh → اطلع
    if (!LoginStorage.accessTokenExpiresSoon) return;

    _refreshCompleter = Completer<void>();

    try {
      final success = await refreshToken();

      if (!success) {
        _refreshCompleter!.completeError("SESSION_EXPIRED");
        logout();
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

  // =========================
  // 🔥 ACTUAL REFRESH CALL
  // =========================
  Future<bool> refreshToken() async {
    final token = LoginStorage.token;
    final rToken = LoginStorage.refreshToken;

    if (token == null || rToken == null) return false;

    try {
      final res = await ApiClient.refreshDio.post(
        EndPoints.refreshToken,
        data: {"token": token, "refreshToken": rToken},
      );

      final responseData = res.data;
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
      if (e is DioException &&
          e.response != null &&
          e.response!.statusCode! >= 400 &&
          e.response!.statusCode! < 500) {
        return false;
      }

      return false;
    }
  }

  // =========================
  // 🔁 RETRY REQUEST
  // =========================
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

  // =========================
  // ❌ FAIL QUEUE
  // =========================
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

  // =========================
  // 🚪 LOGOUT
  // =========================
  void logout() {
    if (loggedOut) return;

    loggedOut = true;
    LoginStorage.clear();
    SessionDialog.showSessionExpired();
  }
}
