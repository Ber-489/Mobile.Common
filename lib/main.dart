import 'dart:ui';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'resource/config/config_environment.dart';

import 'app.dart';

// Khởi tạo GlobalKey
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //Custom error screen
  // ErrorWidget.builder = (details) {
  //   return ErrorMainWidget('${details.exception}');
  // };
  //==========
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

  ///Send Error crash app
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  ///Handle Error crash app
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}
