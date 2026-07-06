import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/constants.dart';

class StorageService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Token
  static Future<void> saveToken(String token) async {
    await _prefs.setString(AppConstants.tokenKey, token);
  }

  static String? getToken() {
    return _prefs.getString(AppConstants.tokenKey);
  }

  // User data
  static Future<void> saveUser(Map<String, dynamic> user) async {
    await _prefs.setString(AppConstants.userKey, jsonEncode(user));
  }

  static Map<String, dynamic>? getUser() {
    final data = _prefs.getString(AppConstants.userKey);
    if (data != null) {
      return jsonDecode(data);
    }
    return null;
  }

  // Theme
  static Future<void> saveThemeMode(String mode) async {
    await _prefs.setString(AppConstants.themeKey, mode);
  }

  static String? getThemeMode() {
    return _prefs.getString(AppConstants.themeKey);
  }

  // Clear all
  static Future<void> clearAll() async {
    await _prefs.clear();
  }
}
