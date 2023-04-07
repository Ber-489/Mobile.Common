import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:source_base/modules/change_password/controller/change_password_controller.dart';

import '../../../utils/common/animation.dart';
import '../../../utils/common/color.dart';
import '../../../utils/widget/loading/custom_loading_animation.dart';
import '../../../utils/widget/space/space.dart';

part 'input_form_field.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: Get.width,
        height: Get.height,
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
                    _inputForm(
                        controller: controller.txtPassword,
                        hintText: "Nhập mật khẩu"),
                    spaceVertical(height: 20),
                    _inputForm(
                        controller: controller.txtConfirmPassword,
                        hintText: "Nhập lại mật khẩu"),
                    spaceVertical(height: 30),
                    _btnRegister(),
                  ],
                ),
              ),
            ),
            controller.isShowSuccessedAnimation.value
                ? CustomLoadingAnimation.loading(
                    assetName: AnimationCommon.registerSuccess)
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _btnRegister() {
    return GestureDetector(
        onTap: () async => controller.type == 1 ? await controller.doRegister() : await controller.doResetPassword(),
        child: Container(
          width: controller.type == 1 ? 160 : 180,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(controller.type == 1 ? 'Tạo tài khoản' : 'Đặt lại mật khẩu',
                style: TextStyle(color: AppColor.colorLight, fontSize: 18)),
          ),
        ));
  }

  Widget lotieAnimation() {
    return SizedBox(
      width: Get.width,
      height: Get.height / 2,
      child: Lottie.asset(AnimationCommon.register, fit: BoxFit.contain),
    );
  }
}
