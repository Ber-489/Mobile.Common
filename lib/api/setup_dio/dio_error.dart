import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
        );
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioErrorType.unknown:
        if (dioError.message!.contains("SocketException")) {
          message = 'No Internet';
          break;
        }
        message = "Unexpected error occurred";
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Server cannot or will not process the request due to something that is perceived to be a client error';
      case 401:
        return 'Client request has not been completed because it lacks valid authentication credentials for the requested resource';
      case 403:
        return 'Server understands the request but refuses to authorize it.';
      case 404:
        return 'Page not found';
      case 500:
        return 'Server encountered an unexpected condition that prevented it from fulfilling the request';
      case 502:
        return 'Error while acting as a gateway or proxy, received an invalid response from the upstream server';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message;
}
