import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gotrust_popup/packagestatuscode.dart';
import 'resource/deeplinks/handle_deeplink_app_not_run/app_not_run.dart';
import 'resource/deeplinks/handle_deeplink_app_running/app_running.dart';
import 'resource/lang/translation_service.dart';
import 'routes/app_pages.dart';
import 'service/connectivity/wifi.dart';
import 'service/local_auth/local_auth.dart';
import 'utils/app_life_cycle/track_life_cycle.dart';
import 'utils/common/color.dart';
import 'utils/common/data.dart';
import 'utils/common/key_data_local.dart';
import 'utils/stored/shared_preferences/get.dart';
import 'package:uni_links/uni_links.dart';


bool _initialUriIsHandled = false;

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver{

  StreamSubscription? _sub;

  @override
  void initState() {
    /// Khi nào dùng push noti thì mở nó lên
    // FirebaseNotification().initConfig();
    // FirebaseNotification().handleMessage();
    /// =====================================
    _handleInitial();
    _handleInitialAppNotRunning();
    _handleIncomingLinks();
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
  Future<void> _handleInitial() async{
    /// Check device is support biometric FaceID, TouchID or NOT
    AppDataGlobal.biometricType = await LocalAuth.isSupport();
    /// Check status user is turn on biometric or not
    AppDataGlobal.biometricStatus.value = await GetDataFromLocal.getBool(key: KeyDataLocal.keyBiometric) ?? false;
    /// Get type and check type of connect is Wifi, 4G, disconnect internet
    WifiService.connect();
  }


  //Deelink work when app is not run on background
  Future<void> _handleInitialAppNotRunning() async {
    if (!_initialUriIsHandled) {
      _initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri == null) return;

        DeeplinkAppNotRunning.appNotRunning(uri: uri);

      } on FormatException catch (err) {
        GoTrustStatusCodePopup.showSnackBar(
            code: "", title: err.message.toString());
      }
    }
  }

  //Deelink work when app is run on background
  void _handleIncomingLinks() {
    if (!kIsWeb) {
      _sub = uriLinkStream.listen((Uri? uri) {
        if (!mounted) return;
        DeeplinkAppRunning.appRunning(uri: uri);
      }, onError: (err) {
        GoTrustStatusCodePopup.showSnackBar(code: "", title: err.toString());
      });
    }
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