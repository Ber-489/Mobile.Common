import 'package:flutter/material.dart';

import '../../common/color.dart';
import '../../common/text_style.dart';

class CustomText {
  static Widget text(
      {required String text,
        int maxLine = 1,
        TextAlign? textAlign,
        Color? colorText,
        double? fontSize,
        double? lineHeight,
        TextDecoration? textDecoration,
        FontWeight? fontWeight,
        TextStyle? style}) {

    return Text(text,
        maxLines: maxLine,
        textAlign: textAlign,
        overflow: TextOverflow.ellipsis,
        style: style ??
            TextAppStyle.customTextStyle(
                fontSize: fontSize,
                lineHeight: lineHeight,
                color: colorText ?? AppColor.colorDark,
                fontWeight: fontWeight,
                textDecoration: textDecoration));
  }
}
