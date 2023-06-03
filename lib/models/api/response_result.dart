import 'package:dio/dio.dart';
import 'package:flutter_test_app/utils/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_result.freezed.dart';

@freezed
class ResponseResult<T> with _$ResponseResult<T> {
  /// 成功
  const factory ResponseResult.success({
    required Headers headers,
    required T? data,
  }) = Success;

  /// 失敗
  const factory ResponseResult.failure({
    @Default('') String? code,
    @Default(serverConnectionFailure) String message,
  }) = Failure;
}
