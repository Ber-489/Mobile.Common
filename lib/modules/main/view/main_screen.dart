import 'package:awesome_bottom_bar/awesome_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/common/color.dart';
import '../../account/view/setting_screen.dart';
import '../../home/view/home_screen.dart';
import '../../list_chat/view/list_chat_screen.dart';
import '../controller/main_controller.dart';

part 'bottom_bar.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: SingleChildScrollView(
          child: controller.mainWidget.value,
        ),
        bottomNavigationBar: _bottomBar(),
      ),
    );
  }
}
