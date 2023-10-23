import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/common/animation.dart';
import '../../../utils/common/color.dart';
import '../../../utils/widget/space/space.dart';
import '../controller/register_controller.dart';

part 'input_phone_number.dart';

class RegisterScreen extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            lotieAnimation(),
            spaceVertical(height: 20),
            _inputPhoneNumber(),
            spaceVertical(height: 30),
            _btnRegister(),
            spaceVertical(height: 30),
            _btnBack(),
          ],
        ),
      ),
    );
  }

  Widget _btnRegister(){
    return GestureDetector(
        onTap: () async => await controller.doSentOtp(),
        child: Container(
          width: 160,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text('Đăng ký',
                style: TextStyle(
                    color: AppColor.colorLight, fontSize: 18)),
          ),
        ));
  }

  Widget _btnBack(){
    return GestureDetector(
      onTap: Get.back,
      child: const Text('Quay lại',
          style: TextStyle(color: Colors.blueAccent, fontSize: 18)),
    );
  }

  Widget lotieAnimation() {
    return SizedBox(
      width: Get.width,
      height: Get.height / 2,
      child:
          Lottie.asset(AnimationCommon.register, fit: BoxFit.contain),
    );
  }
}
