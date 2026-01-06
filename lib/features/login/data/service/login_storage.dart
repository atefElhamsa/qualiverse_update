import '../../../../core/all_core_imports/all_core_imports.dart';

class LoginStorage {
  // =============================
  // Session tokens (Memory)
  // =============================
  static String? token;
  static String? refreshToken;
  static DateTime? refreshTokenExpiration;

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
  }

  // =============================
  // Set session from API
  // =============================
  static void setSession({
    required String tokenValue,
    required String refreshTokenValue,
    required DateTime refreshTokenExpirationValue,
  }) {
    token = tokenValue;
    refreshToken = refreshTokenValue;
    refreshTokenExpiration = refreshTokenExpirationValue;
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
  }

  // =============================
  // Helpers
  // =============================
  static bool get hasToken => token != null && token!.isNotEmpty;

  static bool get isRefreshTokenExpired {
    if (refreshTokenExpiration == null) return true;
    return DateTime.now().isAfter(refreshTokenExpiration!);
  }

  // Optional – refresh قبل الانتهاء بدقيقة
  static bool get shouldRefreshSoon {
    if (refreshTokenExpiration == null) return false;
    return DateTime.now()
        .add(const Duration(minutes: 1))
        .isAfter(refreshTokenExpiration!);
  }

  // =============================
  // Clear everything (logout)
  // =============================
  static Future<void> clear() async {
    token = null;
    refreshToken = null;
    refreshTokenExpiration = null;

    CashHelper.removeData(key: KeysTexts.token);
    CashHelper.removeData(key: KeysTexts.refreshToken);
    CashHelper.removeData(key: KeysTexts.refreshTokenExpiration);
  }
}
