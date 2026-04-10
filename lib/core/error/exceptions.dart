import 'package:dio/dio.dart';

/// Base class for all high-fidelity application exceptions.
class AppException implements Exception {
  final String message;
  final String? code;

  const AppException(this.message, [this.code]);

  @override
  String toString() => 'AppException: [$code] $message';
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'No Internet Connection', super.code = 'NETWORK_ERROR']);
}

class ServerException extends AppException {
  const ServerException([super.message = 'Server Error', super.code = 'SERVER_ERROR']);
}

class UnauthorisedException extends AppException {
  const UnauthorisedException([super.message = 'Unauthorised Access', super.code = 'AUTH_ERROR']);
}

class ValidationException extends AppException {
  const ValidationException([super.message = 'Invalid Input', super.code = 'VALIDATION_ERROR']);
}

/// Helper to map DioErrors to custom AppExceptions natively.
AppException mapDioErrorToException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
      return const NetworkException();
    case DioExceptionType.badResponse:
      final statusCode = error.response?.statusCode;
      if (statusCode == 401 || statusCode == 403) {
        return const UnauthorisedException();
      }
      return ServerException('Server returned $statusCode', 'HTTP_$statusCode');
    default:
      return const AppException('Something went wrong', 'UNKNOWN');
  }
}
