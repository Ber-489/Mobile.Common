import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:source_base/resource/lang/translation_service.dart';
import 'package:source_base/routes/app_pages.dart';
import 'package:source_base/utils/common/color.dart';
import 'package:source_base/utils/common/data.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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