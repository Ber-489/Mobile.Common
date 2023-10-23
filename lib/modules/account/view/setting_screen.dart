import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/common/color.dart';
import '../controller/setting_controller.dart';

class AccountScreen extends GetView<AccountController> {
  @override
  final controller = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'SettingScreen ${'hello'.tr}',
            style: TextStyle(color: AppColor.colorDark),
          ),

          GestureDetector(
            onTap: () async=> await controller.doCreateAccount(context),
            child: Container(
              width: 100,
              height: 40,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
