import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:otp_pin_field/otp_pin_field.dart';
import 'package:source_base/utils/common/animation.dart';
import 'package:source_base/utils/common/func/countdown_timer.dart';
import 'package:source_base/utils/widget/text/montserrat.dart';

import '../../../utils/common/color.dart';
import '../../../utils/widget/loading/custom_loading_animation.dart';
import '../../../utils/widget/space/space.dart';
import '../controller/verify_otp_controller.dart';

part 'input_verify_otp.dart';

part 'button.dart';

class VerifyOTPScreen extends GetView<VerifyOTPController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: Get.width,
        height: Get.height,
        color: AppColor.colorLight,
        child: Stack(
          children: [
            Positioned(
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    lotieAnimation(),
                    spaceVertical(height: 20),
                    _inputOTPNumber(),
                    spaceVertical(height: 30),
                    _btnResendOTP(),
                    spaceVertical(height: 20),
                    _btnVerifyOTP(),
                    spaceVertical(height: 30),
                    _btnBack(),
                  ],
                ),
              ),
            ),
            controller.isShowLoadingAnimation.value
                ? CustomLoadingAnimation.loading()
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget lotieAnimation() {
    return SizedBox(
      width: Get.width,
      height: Get.height / 2,
      child: Lottie.asset(AnimationCommon.login, fit: BoxFit.contain),
    );
  }
}
