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
  // For dev
  EnvConfiguration(environment: 'dev');
  // For product
  // EnvConfiguration(environment: 'prod');
  //For uat
  // EnvConfiguration(environment: 'uat');
  runApp(const App());
  configLoading();
}
