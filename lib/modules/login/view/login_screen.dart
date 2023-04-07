import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:source_base/utils/common/animation.dart';

import '../../../utils/common/color.dart';
import '../../../utils/widget/space/space.dart';
import '../controller/login_controller.dart';

part 'input_form_field.dart';

class LoginScreen extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
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
              _inputForm(
                  controller: controller.txtPhone,
                  hintText: "Nhập số điện thoại",
                  keyboardType: TextInputType.phone),
              if (!controller.isForgetPassword.value) spaceVertical(height: 20),
              if (!controller.isLoginSms.value &&
                  !controller.isForgetPassword.value)
                _inputForm(
                    controller: controller.txtPassword,
                    hintText: "Nhập mật khẩu"),
              if (!controller.isLoginSms.value &&
                  !controller.isForgetPassword.value)
                spaceVertical(height: 15),
              if (!controller.isForgetPassword.value) _rowOption(),
              spaceVertical(height: 30),
              _btnLogin(),
              spaceVertical(height: 20),
              if (!controller.isLoginSms.value)
                _btnCommon(
                  title: controller.isForgetPassword.value
                      ? "Đăng nhập"
                      : "Quên mật khẩu",
                  onTap: () => controller.doChangeTypeForgetPassword(context),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _btnLogin() {
    return GestureDetector(
        onTap: () async => controller.isForgetPassword.value
            ? await controller.doForgetPassword()
            : await controller.doLogin(),
        child: Container(
          width: 160,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
                controller.isForgetPassword.value ? 'Tiếp tục' : 'Đăng nhập',
                style: TextStyle(color: AppColor.colorLight, fontSize: 18)),
          ),
        ));
  }

  /// Button use for Forget password, Register account, Change type option login
  Widget _btnCommon({required String title, Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Text(title,
          style: const TextStyle(color: Colors.blueAccent, fontSize: 18)),
    );
  }

  Widget _rowOption() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          _btnCommon(
            title: 'Đăng ký',
            onTap: () => controller.doRegister(),
          ),
          const Spacer(),
          _btnCommon(
            title: controller.isLoginSms.value
                ? 'Đăng nhập mật khẩu'
                : 'Đăng nhập bằng SMS',
            onTap: () => controller.doChangeTypeLogin(),
          )
        ],
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
