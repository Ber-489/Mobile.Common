import 'dart:ui';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../common/data.dart';


//App have 4 status when app running
// inactive: ...
// paused: app running on background
// detached: app close - kill app
// resumed: app continues run after paused
Future<void> trackLifeCycleApp({required AppLifecycleState state}) async{
  try {
    //Get name of app life cycle
    // final inactive = AppLifecycleState.inactive.name; // not use
    final paused = AppLifecycleState.paused.name;
    // when detached user must open app from zero **** Don't check
    // final detached = AppLifecycleState.detached.name;
    final resumed = AppLifecycleState.resumed.name;

    var currentState = state.name;

    if (currentState == paused) {
      AppDataGlobal.timeAppPaused = DateTime.now();
      return;
    }

    if (currentState == resumed) {
      if (AppDataGlobal.timeAppPaused == null) {
        return;
      }

      final currentTime = DateTime.now();

      final minutesNotUseApp = currentTime
          .difference(AppDataGlobal.timeAppPaused!)
          .inMinutes;

      AppDataGlobal.timeAppPaused = null;
      if(minutesNotUseApp >= 15){
        await Get.offAllNamed(Routes.SPLASH);
      }
      return;
    }
  }catch(_){}
}