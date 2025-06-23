import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'resource/lang/translation_service.dart';
import 'routes/app_pages.dart';
import 'service/connectivity/wifi.dart';
import 'utils/app_life_cycle/track_life_cycle.dart';
import 'utils/common/color.dart';
import 'utils/common/data.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  StreamSubscription? _sub;

  @override
  void initState() {
    /// Khi nào dùng push noti thì mở nó lên
    // FirebaseNotification().initConfig();
    // FirebaseNotification().handleMessage();
    /// =====================================
    _handleInitial();
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    trackLifeCycleApp(state: state);
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  // Do all necessary func to run app
  Future<void> _handleInitial() async {
    /// Get type and check type of connect is Wifi, 4G, disconnect internet
    WifiService.connect();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        locale: TranslationService.locale,
        fallbackLocale: TranslationService.fallbackLocaleVi,
        translations: TranslationService(),
        initialRoute: Routes.SPLASH,
        defaultTransition: Transition.fadeIn,
        getPages: routePages,
        title: AppDataGlobal.appName,
        builder: EasyLoading.init(),
      ),
    );
  }
}

/// Easyloading not use custom animation
void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.threeBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 20.0
    ..radius = 16.0
    ..lineWidth = 3.0
    ..progressColor = AppColor.colorLight
    ..backgroundColor = AppColor.colorDark.withOpacity(0.8)
    ..indicatorColor = AppColor.colorLight
    ..textColor = AppColor.colorLight
    ..maskColor = AppColor.colorDark.withOpacity(0.5)
    ..animationStyle = EasyLoadingAnimationStyle.opacity
    // ..textStyle = TextAppStyle()
    //     .semiBoldTextStyleExtraSmall()
    //     .copyWith(color: AppColor.colorLight)
    ..dismissOnTap = false
    ..userInteractions = false
    ..contentPadding = const EdgeInsets.all(20);
}

/// Easyloading used custom animation
// void configLoading() {
//   EasyLoading.instance
//     ..loadingStyle = EasyLoadingStyle.custom
//     ..indicatorSize = 20.0
//     ..radius = 16.0
//     ..lineWidth = 3.0
//     ..progressColor = AppColor.colorLight
//     ..backgroundColor = Colors.transparent
//     ..indicatorColor = AppColor.colorLight
//     ..textColor = AppColor.colorLight
//     ..animationStyle = EasyLoadingAnimationStyle.opacity
//     ..indicatorWidget = Lottie.asset(AssetAnimationCustom.loading)
//     ..maskType = EasyLoadingMaskType.clear
//     ..boxShadow = <BoxShadow>[]
//   // ..textStyle = TextAppStyle()
//   //     .semiBoldTextStyleExtraSmall()
//   //     .copyWith(color: AppColor.colorLight)
//     ..dismissOnTap = false
//     ..userInteractions = false
//     ..contentPadding = const EdgeInsets.all(20);
// }
