
import 'package:get/get.dart';
import 'package:source_base/modules/register/controller/register_controller.dart';

class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}