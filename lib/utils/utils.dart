import 'package:gotrust_popup/packagestatuscode.dart';

class Utils {
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
}
