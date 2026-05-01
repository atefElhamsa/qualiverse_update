import '../../../../routing/all_routes_imports.dart';

extension LoginStorageExtension on LoginStorage {
  static bool get tokenExpiresSoon {
    if (LoginStorage.refreshTokenExpiration == null) return false;
    return LoginStorage.refreshTokenExpiration!.isBefore(
      DateTime.now().add(const Duration(seconds: 60)),
    );
  }
}
