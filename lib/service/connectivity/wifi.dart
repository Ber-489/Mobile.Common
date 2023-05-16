import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../utils/common/animation.dart';
import '../../utils/common/data.dart';
import '../../utils/widget/popup/custom_popup.dart';

class WifiService {
  ///ConnectivityResult.mobile = 4G, 5G
  ///ConnectivityResult.wifi = wifi
  ///Auto hide and show popup when app disconnect internet
  static Future<void> connect() async {
    Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      if ((result == ConnectivityResult.wifi) == true ||
          (result == ConnectivityResult.mobile) == true) {
        ///Check internetStatus must false and isPopupVisible is true
        ///To auto hide popup, to avoid hide another popup which popup's not same status
        if (!AppDataGlobal.internetStatus.value &&
            AppDataGlobal.isPopupVisible) {
          AppDataGlobal.isPopupVisible = false;
          Navigator.of(navigatorKey.currentState!.context).pop();
        }

        AppDataGlobal.internetStatus.value = true;
      } else {
        AppDataGlobal.internetStatus.value = false;
        if (AppDataGlobal.isPopupVisible) return;
        AppDataGlobal.isPopupVisible = true;

        await CustomPopup.showAnimation(navigatorKey.currentState!.context,
            title: 'Lỗi kết nối',
            message: 'Đang kết nối....',
            padding: const EdgeInsets.only(bottom: 32),
            margin: const EdgeInsets.symmetric(horizontal: 32),
            animationUrl: AnimationCommon.noInternet)
            .then((value) {
          AppDataGlobal.isPopupVisible = false;
        });
      }
    });
  }
}