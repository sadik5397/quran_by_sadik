import 'package:shared_preferences/shared_preferences.dart';

class LocalSave {
  static set({required String key, required String value}) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  static remove({required String key}) async {
    var pref = await SharedPreferences.getInstance();
    pref.remove(key);
  }

  static clearAll() async {
    var pref = await SharedPreferences.getInstance();
    pref.clear();
  }

  static Future<String?> get({required String key}) async {
    var pref = await SharedPreferences.getInstance();
    String? value = pref.getString(key);
    return value;
  }
}
