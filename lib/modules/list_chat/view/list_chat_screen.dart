
import 'package:source_base/utils/widget/text/montserrat.dart';

import '../controller/list_chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;



class ListChatScreen extends GetView<ListChatController>{
  @override
  final controller = Get.put(ListChatController());

  @override
  Widget build(BuildContext context) {
    return Center(child: CustomText.textPlusJakarta(text: 'ListChatScreen'),);
  }
}
