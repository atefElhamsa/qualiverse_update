import 'package:shared_preferences/shared_preferences.dart';

// Helper class for caching data using shared preferences.
class CashHelper {
  static SharedPreferences? sharedPreferences;

  // Initializes the shared preferences.
  static Future<void> init() async {
    // Creates a SharedPreferences instance.
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // Saves data to shared preferences.
  static Future<void> saveData({
    required String key,
    required String value,
  }) async {
    await sharedPreferences?.setString(key, value);
  }

  // Retrieves data from shared preferences.
  static String? getData({required String key}) {
    return sharedPreferences?.getString(key);
  }

  // Removes data from shared preferences.
  static void removeData({required String key}) {
    sharedPreferences?.remove(key);
  }
}
