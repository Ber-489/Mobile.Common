import 'package:get/get.dart';
import 'package:source_base/utils/common/key_data_local.dart';
import 'package:source_base/utils/stored/shared_preferences/get.dart';
import 'package:source_base/utils/stored/shared_preferences/set.dart';

import '../resource/lang/translation_service.dart';

class CustomLanguage {
  static Future<void> getCurrentLang() async {
    final lang = await GetDataFromLocal.getString(key: KeyDataLocal.keyLang);

    lang == 'En'
        ? Get.updateLocale(TranslationService.fallbackLocaleEn)
        : Get.updateLocale(TranslationService.fallbackLocaleVi);
  }

  static Future<void> doChange() async {
    final lang = await GetDataFromLocal.getString(key: KeyDataLocal.keyLang);

    if (lang == 'En') {
      Get.updateLocale(TranslationService.fallbackLocaleVi);
      await SetDataToLocal.setString(key: KeyDataLocal.keyLang, data: 'Vi');
    } else {
      Get.updateLocale(TranslationService.fallbackLocaleEn);
      await SetDataToLocal.setString(key: KeyDataLocal.keyLang, data: 'En');
    }
  }
}
