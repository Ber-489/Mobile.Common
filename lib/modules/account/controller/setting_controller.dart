import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:source_base/utils/language.dart';

class AccountController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> doCreateAccount(BuildContext context) async {
    await CustomLanguage.doChange();
  }
}
