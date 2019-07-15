import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  ///Define key
  static final String _tokenPrefs = "token";

  ///Token
  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenPrefs, token);
  }

  Future<void> getToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenPrefs);
  }
}
