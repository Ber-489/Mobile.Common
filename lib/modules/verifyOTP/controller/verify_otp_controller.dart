import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/utils.dart';

class VerifyOTPController extends GetxController {
  String phone = Get.arguments['phone'];
  int type = Get.arguments['type'];
  /// 4 type: 0, 1, 2, 3
  /// 0: isNotRegister
  /// 1: isRegister
  /// 2: isForgetPassword
  /// 3: isLoginWithOTP
  String txtOTP = '';

  RxBool isShowLoadingAnimation = false.obs;

  Future<void> checkOtp() async {
    if (!Utils.validateOTP(txtOTP)) return;

    isShowLoadingAnimation.value = true;
    await Future.delayed(const Duration(seconds: 2));

    ///Code to check otp
    // bool status = await PhoneServiceFirebase().verifyOTP(otpUserInput: txtOTP);
    isShowLoadingAnimation.value = false;

    if (type == 0 || type == 3) {
      Get.offAllNamed(Routes.MAIN);
      return;
    }

    // if (status) {
    // SetDataToLocal.setString(
    //     key: KeyDataLocal.keyMasterData,
    //     data: masterDataToJson(MasterData(phone: phone, documentId: phone.substring(1), isLogin: true)));
    Get.offAllNamed(Routes.CHANGEPASSWORD, arguments: {'type': type});
    // }
  }
}
