import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CustomEasyLoading {
  // static Future<void> loadingAnimationLoad({String? status}) async {
  //   await EasyLoading.show(
  //       maskType: EasyLoadingMaskType.custom,
  //       indicator: SizedBox(
  //           width: Get.width,
  //           child: Lottie.asset('assets/animation/verify_login.json')));
  // }

  static Future<void> loadingLoad({String? status}) async {
    await EasyLoading.show(status: status ?? 'Loading...', maskType: EasyLoadingMaskType.custom);
  }

  static Future<void> loadingSuccess({String? status}) async {
    await EasyLoading.showSuccess(status ?? 'Thành công', maskType: EasyLoadingMaskType.custom);
  }

  static Future<void> loadingFail({String? status}) async {
    await EasyLoading.showSuccess(status ?? 'Thất bại', maskType: EasyLoadingMaskType.custom);
  }

  static Future<void> stopLoading() async {
    await EasyLoading.dismiss();
  }
}
