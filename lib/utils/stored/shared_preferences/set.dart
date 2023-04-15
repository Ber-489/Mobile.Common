import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetDataToLocal {
  static Future<void> setString({required String key, required String data}) async {
    final prefs = Get.find<SharedPreferences>();
    prefs.setString(key, data);
  }

  static Future<void> setBool({required String key, required bool data}) async {
    final prefs = Get.find<SharedPreferences>();
    prefs.setBool(key, data);
  }


  static Future<void> clearAll() async {
    final prefs = Get.find<SharedPreferences>();
    prefs.clear();
  }
}
