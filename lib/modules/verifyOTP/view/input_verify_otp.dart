part of 'verify_otp_screen.dart';

extension InputOTPNumber on VerifyOTPScreen {
  Widget _inputOTPNumber() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: OtpPinField(
          otpPinFieldStyle: const OtpPinFieldStyle(
            activeFieldBorderColor: Colors.blueAccent,
            fieldBorderWidth: 1,
          ),
          autoFocus: true,
          otpPinFieldDecoration: OtpPinFieldDecoration.roundedPinBoxDecoration,
          maxLength: 6,
          showCursor: false,
          mainAxisAlignment: MainAxisAlignment.center,
          onSubmit: (text) {
            controller.txtOTP = text;
          },
          onChange: (text) {
            controller.txtOTP = text;
          },
        ));
  }
}
