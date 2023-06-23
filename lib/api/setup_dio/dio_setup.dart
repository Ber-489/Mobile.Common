import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';


import '../../utils/status_api_code/status_api_code.dart';
import '../../utils/utils.dart';
import '../../utils/widget/loading/custom_easy_loading.dart';
import '../url.dart';
import 'dio_error.dart';


class DioClient {
// dio instance
  final Dio _dio;

  DioClient(this._dio) {
    _dio
      ..options.baseUrl = Endpoints.baseUrl
    // ..options.headers = Endpoints.headers
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.responseType = ResponseType.json;
  }

  // Get:-----------------------------------------------------------------------
  Future<Response> get(
      String url, {
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      _dio.options.headers = Endpoints.headers;

      // // Thêm interceptor để xem header
      // _dio.interceptors.add(InterceptorsWrapper(
      //   onRequest: (options, handler) {
      //     // In ra header trước khi gửi yêu cầu
      //     print('Request headers: ${options.headers}');
      //     print('Request body: ${options.data}');
      //     return handler.next(options); // Chuyển tiếp yêu cầu
      //   },
      //   // onResponse: (response, handler) {
      //   //   // In ra header sau khi nhận phản hồi
      //   //   print('Response headers: ${response.headers}');
      //   //
      //   //   return handler.next(response); // Chuyển tiếp phản hồi
      //   // },
      //   onError: (DioError e, handler) {
      //     // Xử lý lỗi
      //     return handler.next(e); // Chuyển tiếp lỗi
      //   },
      // ));

      var response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );


      if(response.statusCode == 200){
        Utils.checkMaintainAPI(isMaintain: response.data['isMaintain'] ?? false);
      }


      return response;
    } on DioError catch (e) {
      CustomEasyLoading.stopLoading();
      final errorMessage = DioExceptions.fromDioError(e).toString();
      await APIStatusCode.check(statusCode: e.response?.statusCode ?? -1, message: errorMessage);

      if (kDebugMode) {
        print('****** Error Call GET API $url: ${e.response?.statusCode ?? ''} $errorMessage');
      }
      return Response(statusCode: 000, requestOptions: RequestOptions());
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
      String url, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      _dio.options.headers = Endpoints.headers;

      // // Thêm interceptor để xem header
      // _dio.interceptors.add(InterceptorsWrapper(
      //   onRequest: (options, handler) {
      //     // In ra header trước khi gửi yêu cầu
      //     print('Request headers: ${options.headers}');
      //     print('${options.data.toString().substring(0, 500)}');
      //     print('${options.data.toString().substring(500)}');
      //     return handler.next(options); // Chuyển tiếp yêu cầu
      //   },
      //   // onResponse: (response, handler) {
      //   //   // In ra header sau khi nhận phản hồi
      //   //   print('Response headers: ${response.headers}');
      //   //
      //   //   return handler.next(response); // Chuyển tiếp phản hồi
      //   // },
      //   onError: (DioError e, handler) {
      //     // Xử lý lỗi
      //     return handler.next(e); // Chuyển tiếp lỗi
      //   },
      // ));

      var response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if(response.statusCode == 200){
        Utils.checkMaintainAPI(isMaintain: response.data['isMaintain'] ?? false);
      }

      return response;
    } on DioError catch (e) {
      CustomEasyLoading.stopLoading();
      final errorMessage = DioExceptions.fromDioError(e).toString();
      await APIStatusCode.check(statusCode: e.response?.statusCode ?? -1, message: errorMessage);

      if (kDebugMode) {
        print('****** Error Call POST API $url: ${e.response?.statusCode ?? ''} $errorMessage');
      }
      return Response(statusCode: 000, requestOptions: RequestOptions());
    }
  }

  // Put:-----------------------------------------------------------------------
  Future<Response> put(
      String url, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      _dio.options.headers = Endpoints.headers;

      var response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if(response.statusCode == 200){
        Utils.checkMaintainAPI(isMaintain: response.data['isMaintain'] ?? false);
      }

      return response;
    } on DioError catch (e) {
      CustomEasyLoading.stopLoading();
      final errorMessage = DioExceptions.fromDioError(e).toString();
      await APIStatusCode.check(statusCode: e.response?.statusCode ?? -1, message: errorMessage);

      if (kDebugMode) {
        print('****** Error Call PUT API $url: ${e.response?.statusCode ?? ''} $errorMessage');
      }
      return Response(statusCode: 000, requestOptions: RequestOptions());
    }
  }

  // Patch:-----------------------------------------------------------------------
  Future<Response> patch(
      String url, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    try {
      _dio.options.headers = Endpoints.headers;

      var response = await _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      if(response.statusCode == 200){
        Utils.checkMaintainAPI(isMaintain: response.data['isMaintain'] ?? false);
      }

      return response;
    } on DioError catch (e) {
      CustomEasyLoading.stopLoading();
      final errorMessage = DioExceptions.fromDioError(e).toString();
      await APIStatusCode.check(statusCode: e.response?.statusCode ?? -1, message: errorMessage);

      if (kDebugMode) {
        print('****** Error Call PATCH API $url: ${e.response?.statusCode ?? ''} $errorMessage');
      }
      return Response(statusCode: 000, requestOptions: RequestOptions());
    }
  }
}

class Endpoints {

  // base url
  static String baseUrl = mainUrl;

  // receiveTimeout
  static const Duration receiveTimeout = Duration(seconds: 15);

  // connectTimeout
  static const Duration connectionTimeout = Duration(seconds: 15);

  // headers
  static Map<String, dynamic> headers = {
    "Content-Type": "application/json",
    // "Accept-Language": AppDataGlobal.appLanguage.value,
  };
}
