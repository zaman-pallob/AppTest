import 'package:dio/dio.dart';

class ExceptionMessage {
  static String getMessage(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionError:
        return "No internet or server does not exist!!";
      case DioExceptionType.connectionTimeout:
        return "Internet is too slow to connect with server with in allotted time!!";
      case DioExceptionType.receiveTimeout:
        return "Response from server taking too long to recieve!!";
      case DioExceptionType.sendTimeout:
        return "Sent timeout!!";
      case DioExceptionType.badResponse:
        return "Bad response";
      default:
        return "Unknown exception thrown";
    }
  }
}
