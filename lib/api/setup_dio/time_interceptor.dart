import 'package:dio/dio.dart';

class TimingInterceptor extends Interceptor {
  int totalApiTime = 0; // Biến để lưu tổng thời gian gọi API

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Ghi lại thời gian bắt đầu
    options.extra['startTime'] = DateTime.now();
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Tính toán thời gian kết thúc
    final startTime = response.requestOptions.extra['startTime'];
    if (startTime is DateTime) {
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime).inMilliseconds;
      totalApiTime += duration;
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Tính toán thời gian nếu có lỗi
    final startTime = err.requestOptions.extra['startTime'];
    if (startTime is DateTime) {
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime).inMilliseconds;
      totalApiTime += duration;
    }
    super.onError(err, handler);
  }
}