import '../../../../core/all_core_imports/all_core_imports.dart';

class LoginStorage {
  // Session tokens (في الذاكرة)
  static String? token;
  static String? refreshToken;

  //  Load once عند فتح التطبيق
  static Future<void> loadFromCache() async {
    token = CashHelper.getData(key: KeysTexts.token);
    refreshToken = CashHelper.getData(key: KeysTexts.refreshToken);
  }

  // Save session tokens
  static void setSession({
    required String tokenValue,
    required String refreshTokenValue,
  }) {
    token = tokenValue;
    refreshToken = refreshTokenValue;
  }

  // Save persistent (remember me)
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
  }

  static bool get hasToken => token != null && token!.isNotEmpty;

  // Clear everything (logout / unauthorized)
  static Future<void> clear() async {
    token = null;
    refreshToken = null;
    CashHelper.removeData(key: KeysTexts.token);
    CashHelper.removeData(key: KeysTexts.refreshToken);
  }
}
