import '../../../../core/all_core_imports/all_core_imports.dart';
import 'login_interceptor.dart';

class LoginStorage {
  // =============================
  // Session tokens (Memory)
  // =============================
  static String? token;
  static String? refreshToken;
  static DateTime? refreshTokenExpiration;
  static DateTime? accessTokenExpiration; // جديد: عمر الـ access token نفسه

  // =============================
  // Load once عند فتح التطبيق
  // =============================
  static Future<void> loadFromCache() async {
    token = CashHelper.getData(key: KeysTexts.token);
    refreshToken = CashHelper.getData(key: KeysTexts.refreshToken);

    final expirationString = CashHelper.getData(
      key: KeysTexts.refreshTokenExpiration,
    );
    if (expirationString != null) {
      refreshTokenExpiration = DateTime.parse(expirationString);
    }

    final accessExpString = CashHelper.getData(
      key: KeysTexts.accessTokenExpiration,
    );
    if (accessExpString != null) {
      accessTokenExpiration = DateTime.tryParse(accessExpString);
    }

    if (hasToken && isRefreshTokenExpired) {
      await clear();
    }
  }

  // =============================
  // Set session from API
  // =============================
  static void setSession({
    required String tokenValue,
    required String refreshTokenValue,
    required DateTime refreshTokenExpirationValue,
    int? expiresInSeconds, // من الـ response: "expiresIn": 900
  }) {
    token = tokenValue;
    refreshToken = refreshTokenValue;
    refreshTokenExpiration = refreshTokenExpirationValue;

    accessTokenExpiration = expiresInSeconds != null
        ? DateTime.now().add(Duration(seconds: expiresInSeconds))
        : DateTime.now().add(const Duration(minutes: 15)); // fallback احتياطي

    LoginInterceptor().loggedOut = false;
  }

  // =============================
  // Save persistent (remember me)
  // =============================
  static Future<void> savePersistent() async {
    if (token != null) {
      await CashHelper.saveData(key: KeysTexts.token, value: token!);
    }

    if (refreshToken != null) {
      await CashHelper.saveData(
        key: KeysTexts.refreshToken,
        value: refreshToken!,
      );
    }

    if (refreshTokenExpiration != null) {
      await CashHelper.saveData(
        key: KeysTexts.refreshTokenExpiration,
        value: refreshTokenExpiration!.toIso8601String(),
      );
    }

    if (accessTokenExpiration != null) {
      await CashHelper.saveData(
        key: KeysTexts.accessTokenExpiration,
        value: accessTokenExpiration!.toIso8601String(),
      );
    }
  }

  // =============================
  // Helpers
  // =============================
  static bool get hasToken => token != null && token!.isNotEmpty;

  static bool get isRefreshTokenExpired {
    if (refreshTokenExpiration == null) return true;
    return DateTime.now().isAfter(refreshTokenExpiration!);
  }

  /// هل الـ access token هيخلص قريب (خلال نص دقيقة)؟
  /// لو مش عارفين الـ expiration → افترض إنه قريب ينتهي
  static bool get accessTokenExpiresSoon {
    if (accessTokenExpiration == null) return true;
    return DateTime.now()
        .add(const Duration(seconds: 30))
        .isAfter(accessTokenExpiration!);
  }

  // =============================
  // Clear everything (logout)
  // =============================
  static Future<void> clear() async {
    token = null;
    refreshToken = null;
    refreshTokenExpiration = null;
    accessTokenExpiration = null;

    CashHelper.removeData(key: KeysTexts.token);
    CashHelper.removeData(key: KeysTexts.refreshToken);
    CashHelper.removeData(key: KeysTexts.refreshTokenExpiration);
    CashHelper.removeData(key: KeysTexts.accessTokenExpiration);
    CashHelper.removeData(key: KeysTexts.meModel);
  }
}
