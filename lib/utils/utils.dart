import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:gotrust_popup/packagestatuscode.dart';
import 'package:path_provider/path_provider.dart';
import 'package:source_base/utils/common/asset/svg.dart';
import 'package:source_base/utils/widget/popup/custom_popup.dart';

class Utils {

  /// Open setting of app in device setting
  // static void openSetting() {
  //   openAppSettings();
  // }

  ///Copy text
  static void copyText({required String text}) {
    FlutterClipboard.copy(text).then((value) async {
      await CustomPopup.showSnackBar(
          title: 'Thông báo', message: 'Đã sao chép');
    });
  }

  /// Check api is maintain or not
  static void checkMaintainAPI(
      {required bool isMaintain, bool isShowPopup = true}) async {
    if (!isMaintain) return;

    if (isShowPopup) {
      CustomPopup.showTextWithImage(Get.context!,
          title: 'Thông báo',
          message: 'Hệ thống đang cập nhật. Quay lại sau bạn nhé',
          titleButton: 'Đã hiểu',
          svgUrl: AssetSVGName.error);
    } else {
      // Code to show full screen
    }
  }

  /// This func use to parse string to phone number include country code
  /// User input 0903847529 or 903847529 ---parse---> (2 case)
  /// Case 1: if isReturnCountryCode = false -> 903847529
  /// Case 2: if isReturnCountryCode = true -> +84903847529
  static String parsePhoneNumber({required String phone, bool isReturnCountryCode = false}) {
    String data = phone.toString().trim();

    if (data.startsWith('+84')) {
      data = data.substring(3);
    }

    if (data.startsWith('0')) {
      data = data.substring(1);
    }

    return isReturnCountryCode ? '+84$data' : data;
  }

  /// Check length of string and check string is number or not
  /// length 6 -> true
  /// ******* ONLY FOR OTP CODE *******
  static bool validateOTP(String otp) {
    int parseOTP = int.tryParse(otp) ?? -1;

    if (parseOTP != -1 && otp.length == 6) return true;

    return false;
  }

  /// Use func parsePhoneNumber to parse string phone to base phone-> 903847529
  /// Check length == 9 -> true
  static bool validatePhone({String? phone}) {
    String data = Utils.parsePhoneNumber(phone: phone ?? '');

    if (data.length != 9) {
      GoTrustStatusCodePopup.showSnackBar(
          code: '404',
          title: "Thông báo",
          message: 'Kiểm tra lại số điện thoại');
      return false;
    }

    return true;
  }

  ///Use for show image noti on Android when user using app
  static Future<String> downloadFile(String url, String fileName) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      final response = await http.get(Uri.parse(url));
      final file = File(filePath);

      await file.writeAsBytes(response.bodyBytes);
      return filePath;
    } catch (e) {
      if (kDebugMode) {
        print('Error from downloadFile: $e'
            '');
      }
      return '';
    }
  }
}
