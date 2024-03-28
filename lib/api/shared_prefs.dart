    import 'dart:async' show Future;
    import 'package:shared_preferences/shared_preferences.dart';

    class SharedPrefs {
      static Future<bool> setString(String key, String value) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.setString(key, value);
      }

      static Future<String?> getString(String key) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getString(key);
      }

      static Future<bool> setBool(String key, bool value) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.setBool(key, value);
      }

      static Future<bool?> getBool(String key) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getBool(key);
      }

      static Future<bool> remove(String key) async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.remove(key);
      }

      static Future<bool> clear() async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.clear();
      }
    }