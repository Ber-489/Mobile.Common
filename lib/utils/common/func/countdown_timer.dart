import 'dart:async';

import 'package:flutter/material.dart';
import '../../widget/text/montserrat.dart';
import '../data.dart';

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({Key? key}) : super(key: key);

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  Timer? _timer;
  int _start = AppDataGlobal.timeToReSendOTP;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> doResendOTP() async{
    _start = AppDataGlobal.timeToReSendOTP;
    startTimer();

    /// Code to resend otp
  }
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if(_start == 0){
         await doResendOTP();
        }
      },
      child: CustomText.textPlusJakarta(
          text: _start == 0 ? 'gửi mã' :' $_start''s', fontSize: 16,colorText: Colors.blueAccent),
    );
  }
}
