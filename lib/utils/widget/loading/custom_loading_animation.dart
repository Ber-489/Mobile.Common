import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CustomLoadingAnimation {
  static Widget loading({String assetName = 'assets/animation/verify_login.json'}) {
    return Container(
      width: Get.width,
      height: Get.height,
      color: Colors.black38,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: SizedBox(
            width: Get.width,
            child: Lottie.asset(assetName),
          ),
        ),
      ),
    );
  }
}
