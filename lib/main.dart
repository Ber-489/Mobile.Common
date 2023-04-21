import 'package:flutter/material.dart';
import 'package:source_base/resource/config/config_environment.dart';

import 'app.dart';


void main() async{

  //Custom error screen
  // ErrorWidget.builder = (details) {
  //   return ErrorMainWidget('${details.exception}');
  // };
  //==========
  WidgetsFlutterBinding.ensureInitialized();
  /// Khi nào dùng firebase mở lên
  /// Nhớ setup FlutterFire -- flutterfire configure
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // For dev
  await EnvConfiguration.initConfig(environment: 'dev');
  // For product
  // await EnvConfiguration.initConfig(environment: 'prod');
  //For uat
  // await EnvConfiguration.initConfig(environment: 'uat');
  runApp(const App());
  configLoading();
}
