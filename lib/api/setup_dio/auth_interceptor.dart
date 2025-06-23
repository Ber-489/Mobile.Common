import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  final Dio _dio;
  bool _isRefreshing = false;
  final List<Function> _retryQueue = [];

  AuthInterceptor(this._dio);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      // Lỗi 401: cần làm mới token
      if (!_isRefreshing) {
        _isRefreshing = true;
        try {
          final newToken = await _refreshToken(); // gọi API refresh token
          // Cập nhật token mới
          await _updateToken(newToken);

          // Chạy lại các request đang chờ
          for (var retry in _retryQueue) {
            retry();
          }

          _retryQueue.clear();
        } catch (e) {
          // Nếu refresh thất bại → xử lý logout
          print("Refresh token failed: $e");
          _retryQueue.clear();
        } finally {
          _isRefreshing = false;
        }
      }

      // Đợi token được làm mới xong rồi retry lại request
      final responseCompleter = Completer<Response>();
      _retryQueue.add(() async {
        final cloneReq = await _retryRequest(err.requestOptions);
        responseCompleter.complete(cloneReq);
      });

      final response = await responseCompleter.future;
      return handler.resolve(response);
    }

    return handler.next(err);
  }

  // Hàm gọi API để refresh token
  Future<String> _refreshToken() async {
    /// Ở đây là sẽ setup xử lý refresh token và call lại api
    // final refreshToken = AppDataGlobal.userInfo.value.refreshToken;
    //
    // final response = await DioClient(
    //   Dio(),
    // ).post('auth/refresh', data: {"refreshToken": refreshToken});
    //
    // final result = loginModelFromJson(jsonEncode(response.data));
    //
    // AppDataGlobal.userInfo.value = result.data ?? LoginData();
    //
    // return result.data?.accessToken ?? '';

    return "";
  }

  // Hàm cập nhật token mới vào Dio và local
  Future<void> _updateToken(String newToken) async {
    _dio.options.headers['Authorization'] = 'Bearer $newToken';
  }

  // Clone lại request cũ để gọi lại
  Future<Response> _retryRequest(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );

    return _dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
