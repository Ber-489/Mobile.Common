import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetDataFromLocal {
  static Future<String> getString({required String key}) async {
    final prefs = Get.find<SharedPreferences>();
    return prefs.getString(key) ?? "";
  }

  static Future<bool> getBool({required String key}) async {
    final prefs = Get.find<SharedPreferences>();
    return prefs.getBool(key) ?? false;
  }

  static Future<void> clearAll() async {
    final prefs = Get.find<SharedPreferences>();
    prefs.clear();
  }
}
