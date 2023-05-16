import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color.dart';

class TextAppStyle {
  /// Extra small text style with:
  ///
  /// fontSize: 12
  ///
  /// fontWeight: 500
  ///
  /// color: black
  static TextStyle extraSmallNormalTextStyle() {
    return GoogleFonts.plusJakartaSans(
        color: AppColor.colorDark, fontSize: 12, fontWeight: FontWeight.w500);
  }

  /// Small text style with:
  ///
  /// fontSize: 14
  ///
  /// fontWeight: 500
  ///
  /// color: black
  static TextStyle smallNormalTextStyle() {
    return GoogleFonts.plusJakartaSans(
        color: AppColor.colorDark, fontSize: 14, fontWeight: FontWeight.w500);
  }

  /// Medium text style with:
  ///
  /// fontSize: 16
  ///
  /// fontWeight: 500
  ///
  /// color: black
  static TextStyle mediumNormalTextStyle() {
    return GoogleFonts.plusJakartaSans(
        color: AppColor.colorDark, fontSize: 16, fontWeight: FontWeight.w500);
  }

  /// Large text style with:
  ///
  /// fontSize: 18
  ///
  /// fontWeight: 500
  ///
  /// color: black
  static TextStyle largeNormalTextStyle() {
    return GoogleFonts.plusJakartaSans(
        color: AppColor.colorDark, fontSize: 18, fontWeight: FontWeight.w500);
  }

  /// Extra small text style with:
  ///
  /// fontSize: 12
  ///
  /// fontWeight: 700
  ///
  /// color: black
  static TextStyle extraSmallBoldTextStyle() {
    return GoogleFonts.plusJakartaSans(
        color: AppColor.colorDark, fontSize: 12, fontWeight: FontWeight.w700);
  }

  /// Small text style with:
  ///
  /// fontSize: 14
  ///
  /// fontWeight: 700
  ///
  /// color: black
  static TextStyle smallBoldTextStyle() {
    return GoogleFonts.plusJakartaSans(
        color: AppColor.colorDark, fontSize: 14, fontWeight: FontWeight.w700);
  }

  /// Medium text style with:
  ///
  /// fontSize: 16
  ///
  /// fontWeight: 700
  ///
  /// color: black
  static TextStyle mediumBoldTextStyle() {
    return GoogleFonts.plusJakartaSans(
        color: AppColor.colorDark, fontSize: 16, fontWeight: FontWeight.w700);
  }

  /// Large text style with:
  ///
  /// fontSize: 18
  ///
  /// fontWeight: 700
  ///
  /// color: black
  static TextStyle largeBoldTextStyle() {
    return GoogleFonts.plusJakartaSans(
        color: AppColor.colorDark, fontSize: 18, fontWeight: FontWeight.w700);
  }

  /// Custom text style.
  static TextStyle customTextStyle(
      {double? fontSize,
        double? lineHeight,
      TextDecoration? textDecoration,
      FontWeight? fontWeight,
      Color? color}) {
    return GoogleFonts.plusJakartaSans(
      fontSize: fontSize,
      height: lineHeight,
      color: color ?? AppColor.colorDark,
      fontWeight: fontWeight,
      decoration: textDecoration,
    );
  }
}
