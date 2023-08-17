part of 'verify_otp_screen.dart';

extension Button on VerifyOTPScreen {
  /// Button to verify OTP text user input with OTP on server
  Widget _btnVerifyOTP() {
    return GestureDetector(
        onTap: () async => await controller.checkOtp(),
        child: Container(
          width: 160,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text('Xác thực',
                style: TextStyle(color: AppColor.colorLight, fontSize: 18)),
          ),
        ));
  }

  /// Button to back the last screen
  Widget _btnBack() {
    return GestureDetector(
      onTap: Get.back,
      child: const Text('Quay lại',
          style: TextStyle(color: Colors.blueAccent, fontSize: 18)),
    );
  }

  /// Button to resend OTP
  Widget _btnResendOTP() {
    return Container(
      margin: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      width: Get.width,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText.textPlusJakarta(
            text: 'resendOTP'.tr,
            fontSize: 16,
          ),
          const CountDownTimer(),
        ],
      ),
    );
  }
}
