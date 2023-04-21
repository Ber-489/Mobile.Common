import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:gotrust_popup/packagestatuscode.dart';
import 'package:source_base/resource/deeplinks/handle_deeplink_app_not_run/app_not_run.dart';
import 'package:source_base/resource/deeplinks/handle_deeplink_app_running/app_running.dart';
import 'package:source_base/resource/lang/translation_service.dart';
import 'package:source_base/routes/app_pages.dart';
import 'package:source_base/utils/common/color.dart';
import 'package:source_base/utils/common/data.dart';
import 'package:uni_links/uni_links.dart';

import 'firebase/notification/firebase_cloud_messaging.dart';

bool _initialUriIsHandled = false;

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  StreamSubscription? _sub;

  @override
  void initState() {
    /// Khi nào dùng push noti thì mở nó lên
    // FirebaseNotification().initConfig();
    // FirebaseNotification().handleMessage();
    /// =====================================
    _handleInitialAppNotRunning();
    _handleIncomingLinks();
    super.initState();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
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