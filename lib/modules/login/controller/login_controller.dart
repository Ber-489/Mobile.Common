import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/utils.dart';
import '../../../utils/widget/loading/custom_easy_loading.dart';

class LoginController extends GetxController {
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtPassword = TextEditingController();

  RxBool isLoginSms = false.obs;
  RxBool isForgetPassword = false.obs;

  /// Change option login with password or otp
  void doChangeTypeLogin() {
    isLoginSms.value = !isLoginSms.value;
  }

  /// Change option login with password or otp
  void doChangeTypeForgetPassword(context) async {
    isForgetPassword.value = !isForgetPassword.value;
  }

  /// Login base on type user chose
  Future<void> doLogin() async {
    /// Login with password
    if (!isLoginSms.value) {
      await doLoginWithPassword();
      return;
    }

    /// Login with sms
    await doLoginWithOTP();
  }

  /// Register new account
  void doRegister() {
    Get.toNamed(Routes.REGISTER);
  }

  /// Forget password
  Future<void> doForgetPassword() async {
    if (!Utils.validatePhone(phone: txtPhone.text)) return;

    await CustomEasyLoading.loadingLoad();

    await Future.delayed(const Duration(seconds: 2));

    await CustomEasyLoading.stopLoading();
    Get.toNamed(Routes.VERIFYOTP,
        arguments: {'phone': txtPhone.text, 'type': 2});
  }

  /// isLoginSms = false -> User chose login with password
  Future<void> doLoginWithPassword() async {
    if (!Utils.validatePhone(phone: txtPhone.text)) return;
    await CustomEasyLoading.loadingLoad();

    await Future.delayed(const Duration(seconds: 2));

    await CustomEasyLoading.stopLoading();
    Get.toNamed(Routes.MAIN);
  }

  /// isLoginSms = true -> User chose login with Sms-Otp
  Future<void> doLoginWithOTP() async {
    if (!Utils.validatePhone(phone: txtPhone.text)) return;
    await CustomEasyLoading.loadingLoad();

    await Future.delayed(const Duration(seconds: 2));

    await CustomEasyLoading.stopLoading();
    Get.toNamed(Routes.VERIFYOTP,
        arguments: {'phone': txtPhone.text, 'type': 3});
  }

  // /// Check biometricStatus = true
  // /// Auto call to login
  // void doLoginWithBiometric() async{
  //   txtPhone.text = AppDataGlobal.user.phone ?? '';
  //
  //   if(!AppDataGlobal.biometricStatus.value) return;
  //
  //   bool status = await LocalAuth.showAuth(localizedReason: 'Xin hãy xác thực để đăng nhập hệ thống');
  //
  //   if(!status) return;
  //
  //   txtPassword.text = AppDataGlobal.user.password ?? '';
  //
  //   doLoginWithPassword();
  // }
}
