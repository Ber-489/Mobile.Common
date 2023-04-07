import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/common/color.dart';
import '../controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  final controller = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: Center(
        child: Text(
          'HomeScreen',
          style: TextStyle(color: AppColor.colorDark),
        ),
      ),
    );
  }
}
