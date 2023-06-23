import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gotrust_popup/packagestatuscode.dart';
import 'package:lottie/lottie.dart';


import '../../common/button.dart';
import '../../common/color.dart';
import '../../common/data.dart';
import '../../common/text_style.dart';
import '../space/space.dart';
import '../text/montserrat.dart';

class CustomPopup {

  static void closeOverlay() {
    AppDataGlobal.currentPriorityPopup = null;
    AppDataGlobal.isShowPopup = false;
    AppDataGlobal.overlayEntry?.remove();
  }

  static Future<void> showSnackBar({
    required String title,
    required String message,
  }) async {
    await GoTrustStatusCodePopup.showSnackBar(
        code: '', title: title, message: message);
  }

  static Future<void> showOnlyText(context,
      {required String title,
        required String message,
        required String titleButton,
        int? priority,
        Function()? onTap}) async {
    if (AppDataGlobal.isShowPopup) {
      if ((priority ?? -1) > (AppDataGlobal.currentPriorityPopup ?? -1)) {
        closeOverlay();
      } else {
        return;
      }
    }
    AppDataGlobal.isShowPopup = true;
    AppDataGlobal.currentPriorityPopup = priority;
    OverlayState overlayState = Overlay.of(context);
    AppDataGlobal.overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                  width: 280,
                  decoration: BoxDecoration(
                      color: AppColor.colorLight,
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText.textPlusJakarta(
                          text: title,
                          maxLine: 2,
                          textAlign: TextAlign.center,
                          style: TextAppStyle.largeBoldTextStyle()
                              .copyWith(color: AppColor.colorTextBlue)),
                      spaceVertical(height: 12),
                      CustomText.textPlusJakarta(
                        text: message,
                        maxLine: 2,
                        textAlign: TextAlign.center,
                      ),
                      spaceVertical(height: 16),
                      CustomButton.commonButton(
                        height: 45,
                        title: titleButton,
                        onTap: () {
                          closeOverlay();
                          onTap?.call();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
    overlayState.insert(AppDataGlobal.overlayEntry!);
  }

  static Future<void> showTextWithImage(context,
      {required String title,
        required String message,
        required String titleButton,
        required String svgUrl,
        bool titleUnderImage = false,
        int? priority,
        Function()? onTap}) async {
    // if (AppDataGlobal.isShowPopup) return;
    if (AppDataGlobal.isShowPopup) {
      if ((priority ?? -1) > (AppDataGlobal.currentPriorityPopup ?? -1)) {
        closeOverlay();
      } else {
        return;
      }
    }

    AppDataGlobal.isShowPopup = true;
    AppDataGlobal.currentPriorityPopup = priority;
    OverlayState overlayState = Overlay.of(context);
    AppDataGlobal.overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                    width: 280,
                    decoration: BoxDecoration(
                        color: AppColor.colorLight,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if(title.isNotEmpty && !titleUnderImage) CustomText.textPlusJakarta(
                            text: title,
                            maxLine: 2,
                            textAlign: TextAlign.center,
                            style: TextAppStyle.largeBoldTextStyle()
                                .copyWith(color: AppColor.colorTextBlue)),
                        if(title.isNotEmpty && !titleUnderImage) spaceVertical(height: 12),
                        SvgPicture.asset(svgUrl,
                            height: 112, fit: BoxFit.contain),
                        if(title.isNotEmpty && titleUnderImage) CustomText.textPlusJakarta(
                            text: title,
                            maxLine: 2,
                            textAlign: TextAlign.center,
                            style: TextAppStyle.largeBoldTextStyle()
                                .copyWith(color: AppColor.colorTextBlue)),
                        if(title.isNotEmpty && titleUnderImage) spaceVertical(height: 12),
                        CustomText.textPlusJakarta(
                          text: message,
                          maxLine: 10,
                          textAlign: TextAlign.center,
                        ),
                        spaceVertical(height: 16),
                        CustomButton.commonButton(
                          height: 45,
                          title: titleButton,
                          onTap: () {
                            closeOverlay();
                            onTap?.call();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )));
    overlayState.insert(AppDataGlobal.overlayEntry!);
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

  static Future<void> showAnimationWithAction(context,
      {required String message,
        required String animationUrl,
        EdgeInsetsGeometry? padding,
        bool repeatAnimation = false,
        required String titleButton,
        int? priority,
        Function()? onTap}) async {
    // if (AppDataGlobal.isShowPopup) return;
    if (AppDataGlobal.isShowPopup) {
      if ((priority ?? -1) > (AppDataGlobal.currentPriorityPopup ?? -1)) {
        closeOverlay();
      } else {
        return;
      }
    }

    AppDataGlobal.isShowPopup = true;
    AppDataGlobal.currentPriorityPopup = priority;
    OverlayState overlayState = Overlay.of(context);
    AppDataGlobal.overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: padding ?? const EdgeInsets.fromLTRB(32, 24, 32, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(animationUrl,
                      fit: BoxFit.contain, repeat: repeatAnimation),
                  CustomText.textPlusJakarta(
                    text: message,
                    maxLine: 1,
                    style: TextAppStyle.mediumBoldTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                  spaceVertical(height: 20),
                  CustomButton.commonButton(
                    height: 40,
                    title: titleButton,
                    onTap: () {
                      closeOverlay();
                      onTap?.call();
                    },
                  )
                ],
              ),
            )));
    overlayState.insert(AppDataGlobal.overlayEntry!);
  }

  static Future<void> showAnimationWithTwoAction(context,
      {required String message,
        required String animationUrl,
        EdgeInsetsGeometry? padding,
        bool repeatAnimation = false,
        required String titleButtonTop,
        required String titleButtonBottom,
        int? priority,
        Function()? onTapTop,
        Function()? onTapBottom}) async {
    // if (AppDataGlobal.isShowPopup) return;
    if (AppDataGlobal.isShowPopup) {
      if ((priority ?? -1) > (AppDataGlobal.currentPriorityPopup ?? -1)) {
        closeOverlay();
      } else {
        return;
      }
    }

    AppDataGlobal.isShowPopup = true;
    AppDataGlobal.currentPriorityPopup = priority;
    OverlayState overlayState = Overlay.of(context);
    AppDataGlobal.overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: padding ?? const EdgeInsets.fromLTRB(32, 24, 32, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Lottie.asset(animationUrl,
                      fit: BoxFit.contain, repeat: repeatAnimation),
                  CustomText.textPlusJakarta(
                    text: message,
                    maxLine: 1,
                    style: TextAppStyle.mediumBoldTextStyle(),
                    textAlign: TextAlign.center,
                  ),
                  spaceVertical(height: 20),
                  CustomButton.commonButton(
                    height: 40,
                    backgroundColor: AppColor.colorLight,
                    borderColor: AppColor.colorTextBlue,
                    titleColor: AppColor.colorTextBlue,
                    title: titleButtonTop,
                    onTap: () {
                      closeOverlay();
                      onTapTop?.call();
                    },
                  ),
                  spaceVertical(height: 10),
                  CustomButton.commonButton(
                    height: 40,
                    title: titleButtonBottom,
                    onTap: () {
                      closeOverlay();
                      onTapBottom?.call();
                    },
                  )
                ],
              ),
            )));
    overlayState.insert(AppDataGlobal.overlayEntry!);
  }

  static Future<void> showWithAction(context,
      {required String title,
        required String message,
        required String titleButtonLeft,
        required String titleButtonRight,
        Color? colorTextLeft,
        Color? colorBorderLeft,
        Color? colorTextRight,
        Color? colorBorderRight,
        int? priority,
        Function()? onTapLeft,
        Function()? onTapRight}) async {
    // if (AppDataGlobal.isShowPopup) return;
    if (AppDataGlobal.isShowPopup) {
      if ((priority ?? -1) > (AppDataGlobal.currentPriorityPopup ?? -1)) {
        closeOverlay();
      } else {
        return;
      }
    }

    AppDataGlobal.isShowPopup = true;
    AppDataGlobal.currentPriorityPopup = priority;
    OverlayState overlayState = Overlay.of(context);
    AppDataGlobal.overlayEntry = OverlayEntry(
        builder: (BuildContext context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
                    width: 280,
                    decoration: BoxDecoration(
                        color: AppColor.colorLight,
                        borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText.textPlusJakarta(
                            text: title,
                            maxLine: 2,
                            textAlign: TextAlign.center,
                            style: TextAppStyle.largeBoldTextStyle()
                                .copyWith(color: AppColor.colorTextBlue)),
                        spaceVertical(height: 12),
                        CustomText.textPlusJakarta(
                          text: message,
                          maxLine: 6,
                          textAlign: TextAlign.center,
                        ),
                        spaceVertical(height: 16),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              flex: 1,
                              child: CustomButton.commonButton(
                                height: 45,
                                title: titleButtonLeft,
                                backgroundColor: AppColor.colorLight,
                                borderColor:
                                colorTextLeft ?? AppColor.colorTextBlue,
                                titleColor:
                                colorBorderLeft ?? AppColor.colorTextBlue,
                                onTap: () {
                                  closeOverlay();
                                  onTapLeft?.call();
                                },
                              ),
                            ),
                            spaceHorizontal(width: 12),
                            Expanded(
                              flex: 1,
                              child: CustomButton.commonButton(
                                height: 45,
                                title: titleButtonRight,
                                borderColor: colorTextRight,
                                titleColor: colorBorderRight,
                                onTap: () {
                                  closeOverlay();
                                  onTapRight?.call();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )));
    overlayState.insert(AppDataGlobal.overlayEntry!);
  }
}
