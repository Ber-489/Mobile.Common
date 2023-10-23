import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../utils/stored/hive/hive_database.dart';
import '../../utils/stored/shared_preferences/init.dart';
import 'environment/Configuration.Debug.dart';
import 'environment/Configuration.PROD.dart';
import 'environment/Configuration.UAT.dart';

class EnvConfiguration {

  static Future<void> initConfig({required String environment}) async {
    /// Create global variable SharedPreferences to use for App
    await Get.putAsync(() => StorageService().init());

    /// Setup HiveDatabase
    await configHiveDataBase();

    /// Setup MainUrl to connect API,.....
    switch (environment) {
      case 'dev':
        debugAppSettings();
        return;
      case 'prod':
        productAppSettings();
        return;
      case 'uat':
        uatAppSettings();
        return;
      default:
        debugAppSettings();
        return;
    }
  }

  // Setup Hive to use in App
  static Future<void> configHiveDataBase() async {
    //For cahe
    final dir = await getApplicationDocumentsDirectory();
    final _hive = HiveDatabase(dir.path);
    await _hive.init();
    // Get.put(ImageCacheDAO(_hive.imageCacheBox), permanent: true);
    // Get.put(HomeCacheDAO(_hive.homeCacheBox), permanent: true);
    // Get.put(MasterDataCacheDAO(_hive.masterDataCacheBox), permanent: true);
  }
}
