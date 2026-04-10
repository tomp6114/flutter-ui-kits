import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_ui_kits/core/error/exceptions.dart';
import 'package:logger/logger.dart';

@singleton
class DioClient {
  final Dio _dio;
  final Logger _log = Logger();

  DioClient(this._dio) {
    _dio.options = BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: 'application/json',
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          _log.d('RESPONSE[${response.statusCode}] =\u003e PATH: ${response.requestOptions.path}');
          return handler.next(response);
        },
        onError: (e, handler) {
          _log.e('ERROR[${e.response?.statusCode}] =\u003e PATH: ${e.requestOptions.path}');
          return handler.next(e);
        },
      ),
    );
  }

  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      throw mapDioErrorToException(e);
    }
  }

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
      final response = await _dio.post(
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
      throw mapDioErrorToException(e);
    }
  }
}

@module
abstract class NetworkModule {
  @singleton
  Dio get dio {
    return Dio();
  }
}
