// import 'package:dio/dio.dart';
//
// class RetryOnStatusCodeInterceptor extends Interceptor {
//   final Dio dio;
//   final int maxRetries;
//
//   RetryOnStatusCodeInterceptor({required this.dio, this.maxRetries = 3});
//
//   @override
//   Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
//     // Kiểm tra nếu lỗi là do status code 525
//     if (err.response?.statusCode == 525) {
//       RequestOptions options = err.requestOptions;
//
//       int retryCount = options.extra['retryCount'] ?? 0;
//
//       if (retryCount < maxRetries) {
//         options.extra['retryCount'] = retryCount + 1;
//
//         try {
//           // Thực hiện gọi lại API
//           final response = await dio.fetch(options);
//           return handler.resolve(response);
//         } catch (e) {
//           // Nếu lỗi vẫn xảy ra sau khi retry
//           return handler.next(err);
//         }
//       }
//     }
//     // Nếu không phải lỗi 525 hoặc vượt quá số lần retry
//     return handler.next(err);
//   }
// }
