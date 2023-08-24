import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../common/color.dart';

class NetworkImageCustom {
  static load(
      {String imageUrl = '',
      double? width,
      double? height,
      IconData? iconError,
      Color? colorIconError,
      double? sizeIconError,
      Color? backgroundColor,
      BoxFit? fit,
      BorderRadiusGeometry? borderRadius,
      EdgeInsetsGeometry? padding,
      bool hideErrorWidget = false,
        bool hideProgressIndicator = true,
      }) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Container(
        padding: padding,
        width: width,
        height: height,
        color: backgroundColor ?? Colors.transparent,
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: fit ?? BoxFit.contain,
          progressIndicatorBuilder:(context, url, downloadProgress) =>  hideProgressIndicator ? const SizedBox() : Center(
              child: SizedBox(
                  width: width == null ? 20 : 20,
                  height: height == null ? 20 : 20,
                  child: CircularProgressIndicator(
                      value: downloadProgress.progress,
                      color: AppColor.colorLight))),
          errorWidget:  (context, url, error) => hideErrorWidget ?  const SizedBox() : Icon(
              iconError ?? Icons.error_outline,
              size: sizeIconError,
              color: colorIconError ?? AppColor.colorLight),
        ),
      ),
    );
  }
}
