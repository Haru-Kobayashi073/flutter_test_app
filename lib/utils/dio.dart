import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'utils.dart';

/// Dio のインスタンスを各種設定を済ませた状態で提供するプロバイダ
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio()
    ..httpClientAdapter = HttpClientAdapter()
    ..options = BaseOptions(
      baseUrl: ref.watch(apibaseUrlProvider),
      connectTimeout: const Duration(milliseconds: 100000),
      receiveTimeout: const Duration(milliseconds: 100000),
      validateStatus: (_) => true,
    )
    ..interceptors.addAll(<Interceptor>[
      HeaderInterceptor(),
      // デバッグモードでは RequestInterceptor を追加
      if (kDebugMode) RequestInterceptor(),
      // デバッグモードでは ResponseInterceptor を追加
      if (kDebugMode) ResponseInterceptor(),

      ConnectivityInterceptor(),
    ]);
  return dio;
});
