import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/common/color.dart';
import '../controller/setting_controller.dart';

class AccountScreen extends GetView<AccountController> {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),

            // Tiêu đề
            Text(
              'Tài khoản của tôi',
              style: TextStyle(
                color: AppColor.colorDark,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            const Icon(Icons.person, size: 100, color: Colors.blueGrey),

            const Spacer(),

            // Nút đăng xuất
            Center(
              child: GestureDetector(
                onTap: () {
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
                },
                child: Container(
                  width: 160,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Đăng xuất',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}