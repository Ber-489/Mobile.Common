
import 'package:get/get_core/src/get_main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:source_base/resource/config/environment/Configuration.Debug.dart';
import 'package:source_base/resource/config/environment/Configuration.PROD.dart';
import 'package:source_base/resource/config/environment/Configuration.UAT.dart';

import '../../utils/stored/hive/hive_database.dart';

class EnvConfiguration {
  EnvConfiguration({required this.environment}) {
    initConfig(environment);
  }

  final String environment;

  void initConfig(String? environment) {
    configHiveDataBase();
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
 void configHiveDataBase() async{
   //For cahe
   final dir = await getApplicationDocumentsDirectory();
   final _hive = HiveDatabase(dir.path);
   await _hive.init();
   // Get.put(ImageCacheDAO(_hive.imageCacheBox), permanent: true);
   // Get.put(HomeCacheDAO(_hive.homeCacheBox), permanent: true);
   // Get.put(MasterDataCacheDAO(_hive.masterDataCacheBox), permanent: true);
 }
}
