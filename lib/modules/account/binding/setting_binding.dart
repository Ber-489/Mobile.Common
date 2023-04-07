
import 'package:get/get.dart';

import '../controller/setting_controller.dart';

class AccountBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AccountController>(() => AccountController());
  }
}