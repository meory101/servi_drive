import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../../core/model/user.dart';

abstract class AuthLocal {
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<void> saveUser(User user);
  Future<User?> getUser();
  Future<void> clearAuth();
}

class AuthLocalImplement implements AuthLocal {
  final SharedPreferences sharedPreferences;

  AuthLocalImplement({required this.sharedPreferences});

  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'auth_user';

  @override
  Future<void> saveToken(String token) async {
    await sharedPreferences.setString(_tokenKey, token);
  }

  @override
  Future<String?> getToken() async {
    return sharedPreferences.getString(_tokenKey);
  }

  @override
  Future<void> saveUser(User user) async {
    // Convert user to JSON string and save
    await sharedPreferences.setString(_userKey, jsonEncode(user.toJson()));
  }

  @override
  Future<User?> getUser() async {
    final userJson = sharedPreferences.getString(_userKey);
    if (userJson != null) {
      return User.fromJson(jsonDecode(userJson));
    }
    return null;
  }

  @override
  Future<void> clearAuth() async {
    await sharedPreferences.remove(_tokenKey);
    await sharedPreferences.remove(_userKey);
  }
} 