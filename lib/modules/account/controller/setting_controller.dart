import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/language.dart';

class AccountController extends GetxController {
  RxString userName = ''.obs;
  RxString userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  void loadUserData() {
    // Dữ liệu mẫu, sau này có thể thay bằng API hoặc SharedPreferences
    userName.value = 'Nguyễn Văn A';
    userEmail.value = 'nguyenvana@example.com';
  }

  void logout() {
    Get.defaultDialog(
      title: 'Xác nhận',
      middleText: 'Bạn có chắc chắn muốn đăng xuất không?',
      textCancel: 'Hủy',
      textConfirm: 'Đồng ý',
      confirmTextColor: Colors.white,
      buttonColor: Colors.blue,
      cancelTextColor: Colors.black54,
      onConfirm: () {
        Get.back();
        Get.snackbar(
          'Thông báo',
          'Đăng xuất thành công',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.8),
          colorText: Colors.white,
        );
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAllNamed('/login');
        });
      },
    );
  }
}
