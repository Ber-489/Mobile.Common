import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:source_base/api/setup_dio/state_tracking_interceptor.dart';
import 'package:source_base/api/setup_dio/time_interceptor.dart';
import 'package:source_base/utils/common/data.dart';

import '../../utils/status_api_code/status_api_code.dart';
import '../../utils/widget/loading/custom_easy_loading.dart';
import '../url.dart';
import 'auth_interceptor.dart';
import 'dio_error.dart';

class DioClient {
  // dio instance
  final Dio _dio = Dio();
  final timingInterceptor = TimingInterceptor();
  final stateTrackingInterceptor = StateTrackingInterceptor();
  Duration receiveTimeout;

  DioClient({this.receiveTimeout = Endpoints.receiveTimeout}) {
    _dio
      ..options.baseUrl = Endpoints.baseUrl
      // ..options.headers = Endpoints.headers
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = receiveTimeout
      ..options.sendTimeout = Endpoints.connectionTimeout
      ..options.responseType = ResponseType.json
      ..interceptors.add(timingInterceptor)
      ..interceptors.add(stateTrackingInterceptor)
      ..interceptors.add(AuthInterceptor(_dio));
  }

  // Get:-----------------------------------------------------------------------
  Future<Response> get(
    String url, {
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    bool isHidePopup = false,
  }) async {
    try {
      _dio.options.headers = Endpoints.headers;

      if (baseUrl != null) _dio.options.baseUrl = baseUrl;

      // _dio.interceptors.add(InterceptorsWrapper(
      //   onRequest: (options, handler) {
      //     if (kDebugMode) {
      //       print('url: ${options.headers}');
      //     }
      //     return handler.next(options); // Chuyển tiếp yêu cầu
      //   },
      //   // onResponse: (response, handler) {
      //   //   // In ra header sau khi nhận phản hồi
      //   //   print('Response headers: ${response.headers}');
      //   //
      //   //   return handler.next(response); // Chuyển tiếp phản hồi
      //   // },
      //   // onError: (DioError e, handler) {
      //   //   // Xử lý lỗi
      //   //   return handler.next(e); // Chuyển tiếp lỗi
      //   // },
      // ));

      var response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      try {
        // Regex để tìm và xóa `x-client-secret`
        String headers = options?.headers.toString() ?? '';
        AppDataGlobal.log.logger.i(
          "Call API Method GET ${response.statusCode} - ${response.requestOptions.uri} (${timingInterceptor.totalApiTime}ms)",
          error:
              '****** Header ***** \n$headers \n****** Request ***** \n$queryParameters \n***** Response****** \n${response.data}',
        );
      } catch (_) {}

      return response;
    } on DioException catch (e) {
      CustomEasyLoading.stopLoading();

      /// Kiểm tra trạng thái bảo trì
      // if (e.response?.statusCode == 503) {
      //   if (getx.Get.currentRoute != Routes.HOME) {
      //     getx.Get.offAndToNamed(Routes.HOME);
      //   }
      //
      //   await CustomPopup.showTextWithImage(getx.Get.context,
      //       title: 'Thông báo',
      //       message:
      //           'Dịch vụ đang được bảo trì \nXin vui lòng thử lại sau ít phút',
      //       titleButton: 'Đã hiểu',
      //       svgUrl: AssetImageName.maintain);
      //
      //   return Response(statusCode: 503, requestOptions: RequestOptions());
      // }

      try {
        String headers = options?.headers.toString() ?? '';

        AppDataGlobal.log.logger.e(
          "Call API Method GET ${e.response?.statusCode} - $url (${timingInterceptor.totalApiTime}ms)",
          error:
              '****** Header ***** \n$headers \n****** Request ***** \n$queryParameters \n***** Response****** \n${e.response?.data}',
        );
      } catch (_) {}

      final errorMessage = DioExceptions.fromDioError(e).toString();
      await APIStatusCode.check(
        statusCode: e.response?.statusCode ?? -1,
        message: errorMessage,
        isHidePopup: isHidePopup,
      );

      if (kDebugMode) {
        print(
          '****** Error Call GET API $url: ${e.response?.statusCode ?? ''} $errorMessage',
        );
      }
      return e.response ??
          Response(statusCode: 000, requestOptions: RequestOptions());
    }
  }

  // Post:----------------------------------------------------------------------
  Future<Response> post(
    String url, {
    data,
    String? baseUrl,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool isHidePopup = false,
    bool disableWriteLog = false,
  }) async {
    try {
      _dio.options.headers = Endpoints.headers;

      if (baseUrl != null) _dio.options.baseUrl = baseUrl;

      // _dio.interceptors.add(InterceptorsWrapper(
      //   onRequest: (options, handler) {
      //     if (kDebugMode) {
      //       print('url: ${options.uri}');
      //     }
      //     return handler.next(options); // Chuyển tiếp yêu cầu
      //   },
      //   // onResponse: (response, handler) {
      //   //   // In ra header sau khi nhận phản hồi
      //   //   print('date response: ${response.data}');
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

      try {
        // Regex để tìm và xóa `x-client-secret`
        String headers = options?.headers.toString() ?? '';

        AppDataGlobal.log.logger.i(
          "Call API Method POST ${response.statusCode} - ${response.requestOptions.uri} (${timingInterceptor.totalApiTime}ms)",
          error:
              '****** Header ***** \n$headers \n****** Request Query ***** \n$queryParameters \n****** Request Body ***** \n$data \n***** Response****** \n${response.data}',
        );
      } catch (_) {}

      return response;
    } on DioException catch (e) {
      if (kDebugMode) {
        print(
          '****** Error Call POST API $url: ${e.response?.statusCode ?? '--'} $e',
        );
      }
      CustomEasyLoading.stopLoading();

      /// Kiểm tra trạng thái bảo trì
      // if (e.response?.statusCode == 503) {
      //   if (getx.Get.currentRoute != Routes.HOME) {
      //     getx.Get.offAndToNamed(Routes.HOME);
      //   }
      //
      //   await CustomPopup.showTextWithImage(getx.Get.context,
      //       title: 'Thông báo',
      //       message:
      //           'Dịch vụ đang được bảo trì \nXin vui lòng thử lại sau ít phút',
      //       titleButton: 'Đã hiểu',
      //       svgUrl: AssetImageName.maintain);
      //
      //   return Response(statusCode: 503, requestOptions: RequestOptions());
      // }

      try {
        // Regex để tìm và xóa `x-client-secret`
        String headers = options?.headers.toString() ?? '';

        AppDataGlobal.log.logger.e(
          "Call API Method POST ${e.response?.statusCode} - $url (${timingInterceptor.totalApiTime}ms)",
          error:
              '****** Header ***** \n$headers \n****** Request Data***** \n$data \n****** Request QueryParameters***** \n$queryParameters \n***** Response****** \n${e.response?.data}',
        );
      } catch (_) {}

      final errorMessage = DioExceptions.fromDioError(e).toString();
      await APIStatusCode.check(
        statusCode: e.response?.statusCode ?? -1,
        message: errorMessage,
        isHidePopup: isHidePopup,
      );

      return e.response ??
          Response(statusCode: 000, requestOptions: RequestOptions());
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
    bool isHidePopup = false,
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

      try {
        // Regex để tìm và xóa `x-client-secret`
        String headers = options?.headers.toString() ?? '';

        AppDataGlobal.log.logger.i(
          "Call API Method PUT ${response.statusCode} - ${response.requestOptions.uri} (${timingInterceptor.totalApiTime}ms)",
          error:
              '****** Header ***** \n$headers \n****** Request Query ***** \n$queryParameters \n****** Request Body ***** \n$data \n***** Response****** \n${response.data}',
        );
      } catch (_) {}

      return response;
    } on DioException catch (e) {
      CustomEasyLoading.stopLoading();

      /// Kiểm tra trạng thái bảo trì
      // if (e.response?.statusCode == 503) {
      //   if (getx.Get.currentRoute != Routes.HOME) {
      //     getx.Get.offAndToNamed(Routes.HOME);
      //   }
      //
      //   await CustomPopup.showTextWithImage(getx.Get.context,
      //       title: 'Thông báo',
      //       message:
      //           'Dịch vụ đang được bảo trì \nXin vui lòng thử lại sau ít phút',
      //       titleButton: 'Đã hiểu',
      //       svgUrl: AssetImageName.maintain);
      //
      //   return Response(statusCode: 503, requestOptions: RequestOptions());
      // }

      try {
        // Regex để tìm và xóa `x-client-secret`
        String headers = options?.headers.toString() ?? '';

        AppDataGlobal.log.logger.e(
          "Call API Method PUT ${e.response?.statusCode} - $url (${timingInterceptor.totalApiTime}ms)",
          error:
              '****** Header ***** \n$headers \n****** Request Data***** \n$data \n****** Request QueryParameters***** \n$queryParameters \n***** Response****** \n${e.response?.data}',
        );
      } catch (_) {}

      final errorMessage = DioExceptions.fromDioError(e).toString();
      await APIStatusCode.check(
        statusCode: e.response?.statusCode ?? -1,
        message: errorMessage,
        isHidePopup: isHidePopup,
      );

      if (kDebugMode) {
        print(
          '****** Error Call PUT API $url: ${e.response?.statusCode ?? ''} $errorMessage',
        );
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
    bool isHidePopup = false,
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

      return response;
    } on DioException catch (e) {
      CustomEasyLoading.stopLoading();

      /// Kiểm tra trạng thái bảo trì
      // if (e.response?.statusCode == 503) {
      //   if (getx.Get.currentRoute != Routes.HOME) {
      //     getx.Get.offAndToNamed(Routes.HOME);
      //   }
      //
      //   await CustomPopup.showTextWithImage(getx.Get.context,
      //       title: 'Thông báo',
      //       message:
      //           'Dịch vụ đang được bảo trì \nXin vui lòng thử lại sau ít phút',
      //       titleButton: 'Đã hiểu',
      //       svgUrl: AssetImageName.maintain);
      //
      //   return Response(statusCode: 503, requestOptions: RequestOptions());
      // }

      final errorMessage = DioExceptions.fromDioError(e).toString();
      await APIStatusCode.check(
        statusCode: e.response?.statusCode ?? -1,
        message: errorMessage,
        isHidePopup: isHidePopup,
      );

      if (kDebugMode) {
        print(
          '****** Error Call PATCH API $url: ${e.response?.statusCode ?? ''} $errorMessage',
        );
      }
      return Response(statusCode: 000, requestOptions: RequestOptions());
    }
  }

  // Delete:-----------------------------------------------------------------------
  Future<Response> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool isHidePopup = false,
  }) async {
    try {
      _dio.options.headers = Endpoints.headers;

      var response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );

      try {
        // Regex để tìm và xóa `x-client-secret`
        String headers = options?.headers.toString() ?? '';

        AppDataGlobal.log.logger.i(
          "Call API Method DELETE ${response.statusCode} - ${response.requestOptions.uri} (${timingInterceptor.totalApiTime}ms)",
          error:
              '****** Header ***** \n$headers \n****** Request Query ***** \n$queryParameters \n****** Request Body ***** \n$data \n***** Response****** \n${response.data}',
        );
      } catch (_) {}

      return response;
    } on DioException catch (e) {
      CustomEasyLoading.stopLoading();

      /// Kiểm tra trạng thái bảo trì
      // if (e.response?.statusCode == 503) {
      //   if (getx.Get.currentRoute != Routes.HOME) {
      //     getx.Get.offAndToNamed(Routes.HOME);
      //   }
      //
      //   await CustomPopup.showTextWithImage(getx.Get.context,
      //       title: 'Thông báo',
      //       message:
      //           'Dịch vụ đang được bảo trì \nXin vui lòng thử lại sau ít phút',
      //       titleButton: 'Đã hiểu',
      //       svgUrl: AssetImageName.maintain);
      //
      //   return Response(statusCode: 503, requestOptions: RequestOptions());
      // }

      try {
        // Regex để tìm và xóa `x-client-secret`
        String headers = options?.headers.toString() ?? '';

        AppDataGlobal.log.logger.e(
          "Call API Method DELETE ${e.response?.statusCode} - $url (${timingInterceptor.totalApiTime}ms)",
          error:
              '****** Header ***** \n$headers \n****** Request Data***** \n$data \n****** Request QueryParameters***** \n$queryParameters \n***** Response****** \n${e.response?.data}',
        );
      } catch (_) {}

      final errorMessage = DioExceptions.fromDioError(e).toString();
      await APIStatusCode.check(
        statusCode: e.response?.statusCode ?? -1,
        message: errorMessage,
        isHidePopup: isHidePopup,
      );

      if (kDebugMode) {
        print(
          '****** Error Call PUT API $url: ${e.response?.statusCode ?? ''} $errorMessage',
        );
      }
      return Response(statusCode: 000, requestOptions: RequestOptions());
    }
  }
}

class Endpoints {
  // base url
  static String baseUrl = mainURL;

  // receiveTimeout
  static const Duration receiveTimeout = Duration(seconds: 60);

  // connectTimeout
  static const Duration connectionTimeout = Duration(seconds: 60);

  // headers
  static Map<String, dynamic> headers = {
    "Content-Type": "application/json",
    // "Accept-Language": AppDataGlobal.appLanguage.value,
  };
}
