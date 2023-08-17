import 'package:flutter/foundation.dart';
import 'package:gotrust_popup/packagestatuscode.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  static final LocalAuthentication auth = LocalAuthentication();

  static Future<bool> authenticateIsAvailable() async {
    final isAvailable = await auth.canCheckBiometrics;
    final isDeviceSupported = await auth.isDeviceSupported();

    if (kDebugMode) {
      print(
          '******** Biometric - isAvailable: $isAvailable --- isDeviceSupported: $isDeviceSupported ******');
    }
    return isAvailable && isDeviceSupported;
  }

  /// Check user device is support faceId/touchId or not
  /// FaceID -> TouchID -> Password
  static Future<String> isSupport() async {
    bool isAvailable = await authenticateIsAvailable();

    if (!isAvailable) return '';

    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    // if (kDebugMode) {
    //   print('List<BiometricType>: $availableBiometrics');
    // }

    if (availableBiometrics.contains(BiometricType.face)) {
      return 'FaceID';
    }

    if (availableBiometrics.contains(BiometricType.fingerprint)) {
      return 'TouchID';
    }
    return '';
  }

  static Future<bool> showAuth(
      {bool biometricOnly = false, required String localizedReason}) async {
    try {
      bool isAvailable = await authenticateIsAvailable();
      if (!isAvailable) return false;

      final bool didAuthenticate = await auth.authenticate(
        localizedReason: localizedReason,
        options: AuthenticationOptions(
            biometricOnly: biometricOnly,
            useErrorDialogs: true,
            stickyAuth: false
        ),
      );

      return didAuthenticate;
    } catch (e) {
      GoTrustStatusCodePopup.showSnackBar(
          code: '', title: 'Thông báo', message: 'Có lỗi xảy ra - $e');
      return false;
    }
  }
}
