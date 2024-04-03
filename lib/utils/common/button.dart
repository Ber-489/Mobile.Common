import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../widget/space/space.dart';
import '../widget/text/montserrat.dart';
import 'color.dart';
import 'data.dart';

class CustomButton {
  static Widget commonButton(
      {required String title,
        Function()? onTap,
        bool disableButton = false,
        double? height,
        double? width,
        Color? backgroundColor,
        Color? borderColor,
        Color? titleColor}) {
    return GestureDetector(
      onTap: disableButton ? null : onTap,
      child: Container(
        height: height ?? 56,
        width: width ?? Get.width,
        decoration: BoxDecoration(
          color: disableButton
              ? AppColor.colorDisableButton
              : backgroundColor ?? AppColor.colorButton,
          border: borderColor != null ? Border.all(color: borderColor) : null,
          borderRadius: BorderRadius.circular(
            AppDataGlobal.border,
          ),
        ),
        child: Center(
            child: CustomText.text(
                text: title,
                maxLine: 1,
                fontWeight: FontWeight.w700,
                fontSize: 16,
                textDecoration: TextDecoration.none,
                colorText: titleColor ?? AppColor.colorLight)),
      ),
    );
  }

  static Widget buttonWithIcon(
      {required String assetSVG,
        Function()? onTap,
        Color? iconColor,
        Color? selectedColor,
        bool isSelect = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          border: Border.all(
              color: isSelect
                  ? AppColor.colorButton
                  : AppColor.colorGreyBorderButton),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: SvgPicture.asset(
            assetSVG,
            colorFilter: ColorFilter.mode(
                isSelect
                    ? AppColor.colorButton
                    : iconColor ?? AppColor.colorDark,
                BlendMode.srcIn),
          ),
        ),
      ),
    );
  }

  static Widget buttonTextWithIcon(
      {required String title,
        required String assetSVG,
        Function()? onTap,
        bool disableButton = false,
        double? height,
        double? width,
        Color? backgroundColor,
        Color? borderColor,
        Color? iconColor,
        Color? titleColor}) {
    return GestureDetector(
      onTap: disableButton ? null : onTap,
      child: Container(
        height: height ?? 56,
        width: width ?? Get.width,
        decoration: BoxDecoration(
          color: disableButton
              ? AppColor.colorDisableButton
              : backgroundColor ?? AppColor.colorButton,
          border: borderColor != null ? Border.all(color: borderColor) : null,
          borderRadius: BorderRadius.circular(
            AppDataGlobal.border,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              assetSVG,
              colorFilter: ColorFilter.mode(
                  iconColor ?? AppColor.colorLight, BlendMode.srcIn),
            ),
            spaceHorizontal(width: 16),
            CustomText.text(
                text: title,
                maxLine: 1,
                fontWeight: FontWeight.w700,
                fontSize: 16,
                textDecoration: TextDecoration.none,
                colorText: titleColor ?? AppColor.colorLight),
          ],
        ),
      ),
    );
  }
}
