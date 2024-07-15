import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        .listen((List<ConnectivityResult> resultList) async {
      ConnectivityResult result = resultList.first;
      if ((result == ConnectivityResult.wifi) == true ||
          (result == ConnectivityResult.mobile) == true ||
          (result == ConnectivityResult.ethernet) == true) {
        ///Check internetStatus must false and isPopupVisible is true
        ///To auto hide popup, to avoid hide another popup which popup's not same status
        if (!AppDataGlobal.internetStatus.value &&
            AppDataGlobal.isPopupVisible) {
          AppDataGlobal.isPopupVisible = false;
          Navigator.of(Get.context!).pop();
        }

        AppDataGlobal.internetStatus.value = true;
      } else {
        AppDataGlobal.internetStatus.value = false;
        if (AppDataGlobal.isPopupVisible) return;
        AppDataGlobal.isPopupVisible = true;

        await CustomPopup.showAnimation(Get.context,
            title: 'Lỗi kết nối',
            message: 'Đang kết nối....',
            padding: const EdgeInsets.only(bottom: 32),
            margin: const EdgeInsets.symmetric(horizontal: 32),
            isShowButton: true, onTap: () async {
              AppDataGlobal.isPopupVisible = false;
              Navigator.of(Get.context!).pop();
              // final status = await WifiService.check();
              //
              // if ((status == ConnectivityResult.wifi) == true ||
              //     (status == ConnectivityResult.mobile) == true) {
              //   ///Check internetStatus must false and isPopupVisible is true
              //   ///To auto hide popup, to avoid hide another popup which popup's not same status
              //   if (!AppDataGlobal.internetStatus.value &&
              //       AppDataGlobal.isPopupVisible) {
              //     AppDataGlobal.isPopupVisible = false;
              //     Navigator.of(Get.context!).pop();
              //   }
              //
              //   AppDataGlobal.internetStatus.value = true;
              // }
            }, animationUrl: AnimationCommon.noInternet)
            .then((value) {
          AppDataGlobal.isPopupVisible = false;
        });
      }
    });
  }

// static Future<ConnectivityResult> check() async {
//   final connectivityResult = await (Connectivity().checkConnectivity());
//   return connectivityResult;
// }
}
