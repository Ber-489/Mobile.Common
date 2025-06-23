import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:source_base/utils/common/data.dart';
import 'resource/config/config_environment.dart';

import 'app.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  AppDataGlobal.log.initLog();

  //Custom error screen
  // ErrorWidget.builder = (details) {
  //   return ErrorMainWidget('${details.exception}');
  // };
  //==========

  // For dev
  await EnvConfiguration.initConfig(environment: 'dev');
  // For product
  // await EnvConfiguration.initConfig(environment: 'prod');
  //For uat
  // await EnvConfiguration.initConfig(environment: 'uat');
  runApp(const App());
  configLoading();
}
