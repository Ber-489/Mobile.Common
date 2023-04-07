import 'package:hive/hive.dart';



class HiveDatabase {
  // late final Box<ImageCacheModel> imageCacheBox;
  // late final Box<HomeCacheModel> homeCacheBox;
  // late final Box<MasterDataCacheModel> masterDataCacheBox;
  final String path;

  HiveDatabase(this.path);

  Future<void> init() async {
    // Hive
    //   ..init(path)
    //   ..registerAdapter(ImageCacheModelAdapter())
    // ..registerAdapter(HomeCacheModelAdapter())
    //   ..registerAdapter(MasterDataCacheModelAdapter());
    // imageCacheBox = await Hive.openBox(ImageCacheModel.hiveKey);
    // homeCacheBox = await Hive.openBox(HomeCacheModel.hiveKey);
    // masterDataCacheBox = await Hive.openBox(MasterDataCacheModel.hiveKey);
  }
}
