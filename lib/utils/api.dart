import 'package:hooks_riverpod/hooks_riverpod.dart';

/// HTTP 通信でのエラーの種別の列挙
enum ErrorCode {
  networkNotConnected,
}

final apibaseUrlProvider = Provider<String>((ref) {
  const flavor = String.fromEnvironment('FLAVOR');
  switch (flavor) {
    case 'dev':
      return 'http://localhost:33000/';
    // return 'http://192.168.0.15:33000/';
    case 'stg':
      return 'http://localhost:33000/';
    case 'prod':
      return 'http://localhost:33000/';
    default:
      throw AssertionError('Invalid flavor.');
  }
});
