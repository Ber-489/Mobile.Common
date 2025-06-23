import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
        );
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;
      case DioExceptionType.unknown:
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
        return 'Yêu cầu không hợp lệ. Vui lòng kiểm tra lại thông tin hoặc liên hệ nhân viên hỗ trợ';
      case 401:
        return 'Vui lòng đăng nhập và thử lại. Nếu chưa có tài khoản, hãy đăng ký';
      case 403:
        return 'Truy cập thất bại\nVui lòng kiểm tra lại quyền truy cập hoặc liên hệ nhân viên để được hỗ trợ';
      case 404:
        return 'Không tìm thấy trang yêu cầu\nKiểm tra lại link hoặc quay lại trang chủ';
      case 500:
        return 'Có sự cố xảy ra trên máy chủ\nVui lòng thử lại sau. Nếu lỗi vẫn tiếp diễn, hãy liên hệ với bộ phận hỗ trợ.';
      case 502:
        return 'Máy chủ gặp sự cố khi phản hồi yêu cầu\nHãy đợi vài phút và thử lại. Nếu vẫn không được, liên hệ với bộ phận hỗ trợ';
      default:
        return 'Hệ thống có vấn đề vui lòng thử lại - $statusCode';
    }
  }

  @override
  String toString() => message;
}
