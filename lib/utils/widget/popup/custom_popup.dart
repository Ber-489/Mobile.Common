import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gotrust_popup/packagestatuscode.dart';
import 'package:lottie/lottie.dart';

import '../../common/color.dart';
import '../../common/text_style.dart';
import '../text/montserrat.dart';

class CustomPopup {
  static Future<void> showSnackBar({
    required String title,
    required String message,
  }) async {
    await GoTrustStatusCodePopup.showSnackBar(
        code: '', title: title, message: message);
  }

  static Future<void> showAnimation(context,
      {required String title,
      required String message,
      required String animationUrl,
      EdgeInsetsGeometry? padding,
      EdgeInsetsGeometry? margin}) async {
    await showGeneralDialog(
        context: context,
        barrierColor: Colors.black12.withOpacity(0.3), // Background color
        barrierDismissible: false,
        pageBuilder: (context, animation, secondaryAnimation) {
          return Center(
            child: Container(
              margin: margin,
              padding: padding ?? const EdgeInsets.fromLTRB(16, 32, 16, 32),
              decoration: BoxDecoration(
                  color: AppColor.colorLight,
                  borderRadius: BorderRadius.circular(16)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // CustomText.textPlusJakarta(
                  //     text: title,
                  //     maxLine: 2,
                  //     textAlign: TextAlign.center,
                  //     style: TextAppStyle.largeBoldTextStyle()
                  //         .copyWith(color: AppColor.colorTextBlue)),
                  // spaceVertical(height: 12),
                  Lottie.asset(animationUrl, fit: BoxFit.contain),
                  // spaceVertical(height: 12),
                  CustomText.textPlusJakarta(
                    text: message,
                    maxLine: 1,
                    style: TextAppStyle.mediumBoldTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
