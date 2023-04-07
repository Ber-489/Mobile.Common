import 'package:get/get.dart';

import '../controller/list_chat_controller.dart';

class ListChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListChatController>(() => ListChatController());
  }
}
