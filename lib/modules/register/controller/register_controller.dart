
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gotrust_popup/packagestatuscode.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/utils.dart';
import '../../../utils/widget/loading/custom_easy_loading.dart';

class RegisterController extends GetxController{
  TextEditingController txtPhone = TextEditingController();

  bool validatePhone() {
    String data = Utils.parsePhoneNumber(phone: txtPhone.text);

    if (data.length != 9) {
      GoTrustStatusCodePopup.showSnackBar(code: '0', title: "Thông báo", message: 'Kiểm tra lại số điện thoại');
      return false;
    }

    return true;
  }

  Future<void> doSentOtp() async {
    if (!validatePhone()) return;
    await CustomEasyLoading.loadingLoad();

    await Future.delayed(const Duration(seconds: 2));

    await CustomEasyLoading.stopLoading();
    Get.toNamed(Routes.VERIFYOTP, arguments: {'phone': txtPhone.text, 'type': 1});
  }
}