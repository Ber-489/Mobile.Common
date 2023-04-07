import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'translations/en_US.dart';
import 'translations/vi_VN.dart';

class TranslationService extends Translations {
  static Locale? get locale => Get.deviceLocale;
  static const fallbackLocaleVi = Locale('vi', 'VN');
  static const fallbackLocaleEn = Locale('en', 'US');
  @override
  Map<String, Map<String, String>> get keys => {
        'vi_VN': vi_VN,
        'en_US': en_US,
      };
}

