import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response;
import '../../utils/common/data.dart';
import '../../utils/widget/popup/custom_popup.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  bool _isRefreshing = false;
  final List<Completer<Response>> _queue = [];

  AuthInterceptor(this._dio);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    // Chỉ xử lý khi 401
    if (err.response?.statusCode == 401) {
      final requestOptions = err.requestOptions;

      // 1. Tạo Completer cho request đang gặp lỗi và ngay lập tức thêm vào queue
      final completer = Completer<Response>();
      _queue.add(completer);

      // 2. Nếu chưa đang refresh thì bắt đầu refresh
      if (!_isRefreshing) {
        _isRefreshing = true;
        try {
          // 2.1 Gọi API lấy token mới
          final newToken = await _refreshToken();
          // 2.2 Cập nhật header chung cho Dio
          _dio.options.headers['Authorization'] = 'Bearer $newToken';

          // 2.3 Sau khi có token mới, retry toàn bộ request đang chờ
          for (var pending in _queue) {
            final cloned = await _retryRequest(requestOptions);
            pending.complete(cloned);
          }
        } catch (e) {
          // Nếu refresh thất bại, báo lỗi cho tất cả pending
          for (var pending in _queue) {
            pending.completeError(e);
          }
          // TODO: logout hoặc bắt user đăng nhập lại
        } finally {
          _queue.clear();
          _isRefreshing = false;
        }
      } else {
        CustomPopup.showOnlyText(
          Get.context,
          title: "Thông báo ${err.response?.statusCode ?? ""}",
          message: "Phiên đăng nhập có vấn đề. Vui lòng thử lại.",
          titleButton: 'Đồng ý',
        );
      }

      // 3. Trả về response của completer (sẽ được hoàn thành sau khi refresh+retry)
      return handler.resolve(await completer.future);
    }

    // Với các lỗi khác thì bỏ qua
    return handler.next(err);
  }

  Future<String> _refreshToken() async {
    /// Xử lý call api refresh token
    // final refreshToken = AppDataGlobal.userInfo.value.refreshToken;
    // final r = await _dio.post(
    //   '/auth/refresh',
    //   data: {'refreshToken': refreshToken},
    // );
    // final model = loginModelFromJson(jsonEncode(r.data));
    // AppDataGlobal.userInfo.value = model.data!;
    // return model.data!.accessToken!;

    return "";
  }

  Future<Response> _retryRequest(RequestOptions request) async {
    try {
      final response = await _dio.request(
        request.path,
        data: request.data,
        queryParameters: request.queryParameters,
        options: Options(
          method: request.method,
          headers: {
            /// trong này tuy có Authorization nhưng sẽ bị ghi đè nên ko ảnh hưởng
            ...request.headers ?? {},
            'Authorization': _dio.options.headers['Authorization'],
          },
        ),
      );

      return response;
    } catch (e) {
      if (kDebugMode) {
        print('Error in _retryRequest: $e');
      }
      rethrow;
    }
  }
}
