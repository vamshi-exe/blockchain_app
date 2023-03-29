import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static final PreferencesHelper _instance = PreferencesHelper._internal();

  factory PreferencesHelper() {
    return _instance;
  }

  PreferencesHelper._internal();

  Future<void> saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('auth_token', token);
  }

  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  Future<void> clearAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('auth_token');
  }
}
