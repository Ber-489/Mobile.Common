import 'package:get/get.dart';
import '../common/asset/svg.dart';
import '../widget/popup/custom_popup.dart';

class APIStatusCode {
  static Future<void> check({int? statusCode, String? message}) async {
    String svgUrl = _handleImageError(statusCode);
    String title = _handleTitleError(statusCode);

     CustomPopup.showTextWithImage(Get.context!,
        title: title,
        message: '$message',
        titleButton: 'know'.tr,
        titleUnderImage: true,
        svgUrl: svgUrl);
  }

  static String _handleImageError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return AssetSVGName.error400;
      case 401:
        return AssetSVGName.error401;
      case 403:
        return AssetSVGName.error403;
      case 404:
        return AssetSVGName.error404;
      case 500:
        return AssetSVGName.error500;
      case 502:
        return AssetSVGName.error502;
      default:
        return AssetSVGName.error;
    }
  }

  static String _handleTitleError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 401:
        return 'Unauthorized';
      case 403:
        return 'Forbidden';
      case 404:
        return 'Page not found';
      case 500:
        return 'Internal server error';
      case 502:
        return 'Bad gateway';
      default:
        return 'something_wrong'.tr;
    }
  }
}
