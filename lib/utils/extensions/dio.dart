import 'package:dio/dio.dart';

extension DioErrorTypeExt on DioErrorType {
  /// DioErrorType がタイムアウトに該当するかどうか
  bool get isTimeout => [
        DioErrorType.connectionTimeout,
        DioErrorType.receiveTimeout,
        DioErrorType.sendTimeout,
      ].contains(this);
}
