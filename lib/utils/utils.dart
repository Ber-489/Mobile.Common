import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:gotrust_popup/packagestatuscode.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'common/asset/svg.dart';
import 'widget/popup/custom_popup.dart';

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

  /// Convert string date to DateTime type
  static String convertDateTime({
    required String date,
    String dateFormat = 'HH:mm dd/MM/yyyy',
  }) {
    try {
      DateTime parseDate = DateTime.parse(date);
      var formatDate = DateFormat(dateFormat).format(parseDate.toLocal());
      return formatDate.toString();
    } catch (e) {
      if (kDebugMode) {
        print('************* Error Utils convertDateTime: $e');
      }
      return date;
    }
  }

  /// Auto fill string to dd/MM/yyyy
  static String autoConvertStringToBirthday(
      {required String value, required String valueAfterInput}) {
    //Max length 10
    // "/" -> value.substring(2,3) vs value.substring(5,6)

    // dd -> value.substring(0,2) -> 01 - 31
    // MM -> value.substring(3,5) -> 01 - 12
    // yyyy ->  value.substring(6), -> 1900

    // dd/MM/yyyy
    // / -> 2, 5
    try {
      String data = value;
      int currentYear = DateTime.now().year;
      // If total of string more than 10
      // Auto cut string 0 -> 10
      // if (value.length > 10) return data.substring(0, 10);

      // This func will run when user remove characters
      if (valueAfterInput.length > value.length) {
        if ((value.length == 6 || value.length == 3)) {
          // 18/03/1999 -> length 3,6 is position of "/"
          // Auto remove "/"
          // Exp: 18/03/1 user remove "1" -> auto remove "/" -> 18/03
          return value.substring(0, value.length - 1);
        }
        return value;
      }

      // This func will run when user remove characters
      if ((value.length == 5 || value.length == 2) &&
          (valueAfterInput.length == value.length)) {
        if (value != valueAfterInput) {
          data = '$value/';
        } else {
          return value;
        }
      }

      // This func will run when user input new character
      // Auto check and add "/"
      // Exp: 18/031 -> 18/03/1
      if ((value.length == 6 || value.length == 3)) {
        int checkNumber;
        if (value.length == 3) {
          checkNumber = int.tryParse(value) ?? -1;
        } else {
          checkNumber = int.tryParse(value.substring(3, 6)) ?? -1;
        }

        if (checkNumber > 0) {
          data =
          '${value.substring(0, value.length - 1)}/${value.substring(value.length - 1)}';
          value = data;
        }
      }

      if (value.isNotEmpty && value.length <= 2) {
        // This func check dd
        // dd -> value.substring(0,2) -> 01 - 31
        if (value.length == 1) {
          int day = int.parse(value.substring(0, 1));
          if (day > 3) {
            data = '0$day/';
          }
        } else if (value.length == 2) {
          int day = int.parse(value.substring(0, 2));
          if (day > 31) {
            data = '31/';
          } else {
            data = '$value/';
          }
        }
      } else if (3 < value.length && value.length <= 5) {
        // This func check MM
        // MM -> value.substring(3,5) -> 01 - 12
        if (value.length == 4) {
          int month = int.tryParse(value.substring(3, 4)) ?? -1;
          if (month > 1) {
            if (month == 2) {
              int day = int.parse(value.substring(0, 2));
              if (day > 29) {
                data = data.substring(0, 3);
              } else {
                data = '${data.substring(0, 3)}0$month/';
              }
            } else {
              data = '${data.substring(0, 3)}0$month/';
            }
          }
        } else if (value.length == 5) {
          int month = int.tryParse(value.substring(3, 5)) ?? -1;
          if (month == 2) {
            int day = int.parse(value.substring(0, 2));
            if (day > 29) {
              data = data.substring(0, 3);
            } else {
              data = '$value/';
            }
          } else {
            if (month > 12) {
              data = value.substring(0, 3);
              value = data;
            } else {
              data = '$value/';
            }
          }
        }
      } else if (6 < value.length && value.length <= 10) {
        // This func check yyyy
        // yyyy ->  value.substring(6), -> 1900
        // print('${DateTime.now().year}');
        int length = value.substring(6).length;

        int year = int.tryParse(value.substring(6).toString()) ?? -1;

        if (year == -1) return data;

        // validate year input must less than current year
        int yearToCheck =
            int.tryParse(year.toString().substring(0, length)) ?? 0;
        int yearUseToCheck =
            int.tryParse(currentYear.toString().substring(0, length)) ?? 0;
        // if year bigger than current year
        // Auto check and remove character
        if (yearToCheck > yearUseToCheck) {
          data = value.substring(0, value.length - 1);
        } else {
          // Check old of user input
          // Max old is 200
          if (length == 2 && (yearToCheck < yearUseToCheck - 2)) {
            data = value.substring(0, value.length - 1);
          } else {
            data = value;
          }
        }
      }

      return data;
    } catch (e) {
      if (kDebugMode) {
        print('Error from autoConvertStringToBirthday: $e');
      }
      return '';
    }
  }
}
