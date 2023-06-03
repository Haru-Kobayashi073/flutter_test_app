import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test_app/models/api/response_result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'utils.dart';

final apiClientProvider =
    Provider<ApiClient>((ref) => ApiClient(ref.read(dioProvider)));

class ApiClient {
  ApiClient(this._dio);
  final Dio _dio;

  Future<ResponseResult<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? header,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options ?? Options(headers: header),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      _parseResponse(response);
      return ResponseResult.success(
        headers: response.headers,
        data: response.data,
      );
    } on DioError catch (dioError) {
      final exception = _handleDioError(dioError);
      return ResponseResult.failure(message: exception.toString());
    } on ApiException catch (e) {
      return ResponseResult.failure(
        code: e.code,
        message: e.toString(),
      );
    } on SocketException {
      return const ResponseResult.failure(message: networkNotConnected);
    } on FormatException {
      return const ResponseResult.failure(message: responseFormatNotValid);
    } on Exception catch (e) {
      return ResponseResult.failure(message: e.toString());
    }
  }

  Future<ResponseResult<T>> put<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? header,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options ?? Options(headers: header),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      _parseResponse(response);
      return ResponseResult.success(
        headers: response.headers,
        data: response.data,
      );
    } on DioError catch (dioError) {
      final exception = _handleDioError(dioError);
      return ResponseResult.failure(message: exception.toString());
    } on ApiException catch (e) {
      return ResponseResult.failure(
        code: e.code,
        message: e.toString(),
      );
    } on SocketException {
      return const ResponseResult.failure(message: networkNotConnected);
    } on FormatException {
      return const ResponseResult.failure(message: responseFormatNotValid);
    } on Exception catch (e) {
      return ResponseResult.failure(message: e.toString());
    }
  }

  Future<ResponseResult<T>> post<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? header,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options ?? Options(headers: header),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      _parseResponse(response);
      return ResponseResult.success(
        headers: response.headers,
        data: response.data,
      );
    } on DioError catch (dioError) {
      final exception = _handleDioError(dioError);
      return ResponseResult.failure(message: exception.toString());
    } on ApiException catch (e) {
      return ResponseResult.failure(
        code: e.code,
        message: e.toString(),
      );
    } on SocketException {
      return const ResponseResult.failure(message: networkNotConnected);
    } on FormatException {
      return const ResponseResult.failure(message: responseFormatNotValid);
    } on Exception catch (e) {
      return ResponseResult.failure(message: e.toString());
    }
  }

  Future<ResponseResult<T>> patch<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? header,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final response = await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options ?? Options(headers: header),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      _parseResponse(response);
      return ResponseResult.success(
        headers: response.headers,
        data: response.data,
      );
    } on DioError catch (dioError) {
      final exception = _handleDioError(dioError);
      return ResponseResult.failure(message: exception.toString());
    } on ApiException catch (e) {
      return ResponseResult.failure(
        code: e.code,
        message: e.toString(),
      );
    } on SocketException {
      return const ResponseResult.failure(message: networkNotConnected);
    } on FormatException {
      return const ResponseResult.failure(message: responseFormatNotValid);
    } on Exception catch (e) {
      return ResponseResult.failure(message: e.toString());
    }
  }

  Future<ResponseResult<T>> delete<T>(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? header,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options ?? Options(headers: header),
        cancelToken: cancelToken,
      );
      _parseResponse(response);
      return ResponseResult.success(
        headers: response.headers,
        data: response.data,
      );
    } on DioError catch (dioError) {
      final exception = _handleDioError(dioError);
      return ResponseResult.failure(message: exception.toString());
    } on ApiException catch (e) {
      return ResponseResult.failure(
        code: e.code,
        message: e.toString(),
      );
    } on SocketException {
      return const ResponseResult.failure(message: networkNotConnected);
    } on FormatException {
      return const ResponseResult.failure(message: responseFormatNotValid);
    } on Exception catch (e) {
      return ResponseResult.failure(message: e.toString());
    }
  }

  void _parseResponse(Response<dynamic> response) {
    final statusCode = response.statusCode;
    _validateResponse(statusCode: statusCode);
  }

  /// レスポンスのステータスコードを検証する
  void _validateResponse({
    required int? statusCode,
  }) {
    if (statusCode == 400) {
      throw const ApiException(
        code: '400',
        message: '不正なリクエストです',
      );
    }
    if (statusCode == 401) {
      throw const UnauthorizedException(message: '認証されていません');
    }
    if (statusCode == 403) {
      throw const ForbiddenException(message: '権限がありません');
    }
    if (statusCode == 404) {
      throw const ApiNotFoundException(message: '探しているコンテンツは存在しません');
    }

    if ((statusCode ?? 400) >= 400) {
      throw const ApiException();
    }
  }

  /// DioError を受けて、何かしらの Exception を return する
  /// 呼び出し側ではそれをthrowする
  Exception _handleDioError(DioError dioError) {
    final errorType = dioError.type;
    final errorResponse = dioError.response;
    final dynamic error = dioError.error;

    if (errorType.isTimeout) {
      return const ApiTimeoutException();
    }

    if (error is ErrorCode && error == ErrorCode.networkNotConnected) {
      return const NetworkNotConnectedException();
    }

    if (errorResponse == null) {
      return const ApiException();
    }
    return const ApiException();
  }
}
