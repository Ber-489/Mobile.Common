import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/widget/loading/custom_easy_loading.dart';

class ChangePasswordController extends GetxController {
  int type = Get.arguments['type'];
  /// 2 type: 1, 2
  /// 1: isRegister
  /// 2: isForgetPassword


  TextEditingController txtPassword = TextEditingController();
  TextEditingController txtConfirmPassword = TextEditingController();

  RxBool isShowSuccessedAnimation = false.obs;

  /// Check type = 1 this start this func
  Future<void> doRegister() async {
    await CustomEasyLoading.loadingLoad();

    await Future.delayed(const Duration(seconds: 2));

    await CustomEasyLoading.stopLoading();

    isShowSuccessedAnimation.value = true;
    await Future.delayed(const Duration(seconds: 3));
    isShowSuccessedAnimation.value = false;

    Get.offAllNamed(Routes.MAIN);
  }

  /// Check type = 2 this start this func
  Future<void> doResetPassword() async {
    await CustomEasyLoading.loadingLoad();

    await Future.delayed(const Duration(seconds: 2));

    await CustomEasyLoading.stopLoading();

    isShowSuccessedAnimation.value = true;
    await Future.delayed(const Duration(seconds: 3));
    isShowSuccessedAnimation.value = false;

    Get.offAllNamed(Routes.LOGIN);
  }
}
