

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/color.dart';
import '../../common/text_style.dart';

class CustomText {
  static Widget textMontserrat({required String text, int maxLine = 1, TextAlign? textAlign, Color? colorText, double? fontSize, TextDecoration? textDecoration}){
    return Text(text,
        maxLines: maxLine,
        textAlign: textAlign,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.montserrat(
          fontSize: fontSize,
          color: colorText ?? AppColor.colorDark,
          decoration: textDecoration,
        ));
  }

  static Widget textMontserratBold({String text = '', int maxLine = 1, TextAlign? textAlign, Color? colorText, double? fontSize}){
    return Text(text,
        maxLines: maxLine,
        textAlign: textAlign,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.montserrat(
          fontSize: fontSize,
          color: colorText ?? AppColor.colorDark,
          fontWeight: FontWeight.bold
        ));
  }

  static Widget textPlusJakarta(
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

  static Widget textPlusJakartaBold(
      {String text = '',
        int maxLine = 1,
        TextAlign? textAlign,
        Color? colorText,
        double? fontSize,
        TextStyle? style}) {
    return Text(text,
        maxLines: maxLine,
        textAlign: textAlign,
        overflow: TextOverflow.ellipsis,
        style: style ??
            TextAppStyle.customTextStyle(
                fontSize: fontSize,
                color: colorText ?? AppColor.colorDark,
                fontWeight: FontWeight.bold));
  }
}