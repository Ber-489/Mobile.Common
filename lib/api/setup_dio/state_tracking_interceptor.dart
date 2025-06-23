import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' as getX;

import '../../utils/common/asset/svg.dart';
import '../../utils/widget/popup/custom_popup.dart';

class StateTrackingInterceptor extends InterceptorsWrapper {


  @override
  void onError(DioException error, ErrorInterceptorHandler handler) async {
    await EasyLoading.dismiss();
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      // Xử lý khi xảy ra timeout
      _handleTimeout(error);
    }

    super.onError(error, handler);
  }

  void _handleTimeout(DioException error) {
    String path = error.requestOptions.path;

    CustomPopup.showTextWithImage(getX.Get.context,
        title: 'Thông báo',
        message:
            'Máy chủ không phản hồi vui lòng thử lại hoặc liên hệ nhân viên',
        titleButton: 'Đã hiểu',
        svgUrl: AssetSVGName.error);
  }
}
