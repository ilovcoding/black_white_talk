import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  static String oaCookie = 'oaCookie';
  static String loginMethod = 'loginMethod';
  static String token = 'token';
  static String password = 'password';
  static String hasLogin = 'haslogin';

  static storageString(String key, String value) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setString(key, value);
  }

  static storageBoolen(String key, bool value) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.setBool(key, value);
  }

  static void clean() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    storage.clear();
  }

  static Future<String> getString(String key) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getString(key);
  }
  static Future<bool> getBool(String key) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.getBool(key);
  }
  static delByKey(String key) async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    return storage.remove(key);
  }
}
