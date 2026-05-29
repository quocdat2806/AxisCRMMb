import 'package:dio/dio.dart';
import 'network_info.dart';

/// Interceptor đầu tiên trong chain — chặn request ngay trước khi gửi
/// nếu thiết bị không có internet.
///
/// Khi reject, ném [DioException] với type [DioExceptionType.connectionError].
/// [ErrorMapper] sẽ bắt type này và map thành [Failure.network].
///
/// Luôn đặt interceptor này **trước** [RetryInterceptor] và [LoggingInterceptor]
/// trong danh sách `d.interceptors` của [AppDio].
class NetworkGuardInterceptor extends Interceptor {
  NetworkGuardInterceptor({required this.networkInfo});
  final NetworkInfo networkInfo;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final bool online = await networkInfo.isConnected;
    if (!online) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          error: 'No internet connection',
        ),
      );
    }
    handler.next(options);
  }
}
