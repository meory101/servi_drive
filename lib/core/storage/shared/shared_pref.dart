import 'package:shared_preferences/shared_preferences.dart';

import '../../resource/key_manger.dart';

abstract class AppSharedPreferences {
  static late SharedPreferences _sharedPreferences;

  static init(SharedPreferences sh) {
    _sharedPreferences = sh;
  }

  static clear() {
    _sharedPreferences.clear();
  }

  static void cashUserInfo({
    required String token,
    required String userId,
  }) {
    _sharedPreferences.setString(AppKeyManager.token, token);
    _sharedPreferences.setString(AppKeyManager.userId, userId);
  }

  static cashLanguage({required String language}) {
    _sharedPreferences.setString(AppKeyManager.language, language);
  }
  static cashGuest({required bool guest}) {
    _sharedPreferences.setBool(AppKeyManager.guest, guest);
  }

  static cashUserId({required String id}) {
    _sharedPreferences.setString(AppKeyManager.id, id);
  }

  static Future<void> cashToken({required String token}) async {
  await _sharedPreferences.setString(AppKeyManager.token, token);
}

  static String getLanguage() {
    return _sharedPreferences.getString(AppKeyManager.language) ?? "en";
  }

  static String getUserId() {
    return _sharedPreferences.getString(AppKeyManager.id) ?? "";
  }

  static String getToken() {
    return _sharedPreferences.getString(AppKeyManager.token) ?? '';
  }


  static bool isGuest() {
    return _sharedPreferences.getBool(AppKeyManager.guest) ?? false;
  }
}
