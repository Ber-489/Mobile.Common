import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../utils/common/animation.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: Lottie.asset(
            AnimationCommon.splash,
            onLoaded: controller.onLoadedLotie,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
