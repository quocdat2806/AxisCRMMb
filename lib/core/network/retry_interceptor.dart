import 'dart:async';
import 'dart:math' as math;
import 'package:dio/dio.dart';
import 'package:axis_crm/core/utils/logger.dart';

/// Tự động retry request khi gặp lỗi mạng hoặc server tạm thời (5xx).
///
/// **Khi nào retry:**
/// - Lỗi network: timeout (connect/receive/send), connectionError.
/// - Lỗi server: status code nằm trong [retryAbleStatusCodes] (mặc định 502/503/504).
/// - 4xx **không** retry (lỗi client — sai request, không có nghĩa gì khi gửi lại).
///
/// **Method an toàn để retry:** GET, PUT, DELETE, HEAD, OPTIONS (idempotent).
/// POST **không** nằm trong danh sách mặc định vì có thể gây duplicate action.
/// Cấu hình [OpenAiDio] giữ nguyên mặc định này.
///
/// **Delay:** exponential jitter — 300ms / 700ms / 1500ms + random 0–120ms
/// để tránh thundering herd khi nhiều device cùng retry.
///
/// **FormData với file:** không retry để tránh gửi lại binary stream đã consumed.
///
/// Cách dùng trong [AppDio._build]:
/// ```dart
/// final retry = RetryInterceptor(
///   dio: d,
///   retryAbleStatusCodes: {502, 503, 504},
///   retryMethods: {'GET', 'PUT', 'DELETE', 'HEAD', 'OPTIONS'},
/// );
/// d.interceptors.add(retry); // đặt TRƯỚC LoggingInterceptor
/// ```
class RetryInterceptor extends Interceptor {
  RetryInterceptor({
    required this.dio,
    this.maxAttempts = 3,
    this.retryAbleErrors = const <DioExceptionType>{
      DioExceptionType.connectionTimeout,
      DioExceptionType.receiveTimeout,
      DioExceptionType.sendTimeout,
      DioExceptionType.connectionError,
    },
    this.retryAbleStatusCodes = const <int>{},
    this.delayBuilder,
    this.retryMethods = const <String>{
      'GET',
      'PUT',
      'DELETE',
      'HEAD',
      'OPTIONS',
    },
  });

  final Dio dio;
  final int maxAttempts;
  final Set<DioExceptionType> retryAbleErrors;
  final Set<int> retryAbleStatusCodes;
  final Set<String> retryMethods;
  final Duration Function(int attempt)? delayBuilder;

  Duration _delay(int attempt) {
    if (delayBuilder != null) return delayBuilder!(attempt);
    const List<int> steps = <int>[300, 700, 1500];
    final int base = steps[(attempt - 1).clamp(0, steps.length - 1)];
    final int jitter = math.Random().nextInt(120);
    return Duration(milliseconds: base + jitter);
  }

  bool _bodyIsRetryAble(Object? data) {
    if (data is Stream) return false;
    if (data is FormData && data.files.isNotEmpty) return false;
    return true;
  }

  bool _shouldRetry(DioException err, int attempt) {
    if (attempt >= maxAttempts) return false;

    final String method = err.requestOptions.method.toUpperCase();
    if (!retryMethods.contains(method)) return false;

    final int? code = err.response?.statusCode;
    if (code != null) {
      if (retryAbleStatusCodes.contains(code)) return true;
      if (code >= 400 && code < 500) return false;
    }

    return retryAbleErrors.contains(err.type);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final RequestOptions req = err.requestOptions;
    final int attempt = req.extra['__retry_attempt'] as int? ?? 0;

    if (!_bodyIsRetryAble(req.data) || !_shouldRetry(err, attempt)) {
      return handler.next(err);
    }

    final int nextAttempt = attempt + 1;
    appLogger.w('🔁 Retry attempt $nextAttempt/$maxAttempts → ${req.uri}');
    await Future<void>.delayed(_delay(nextAttempt));

    try {
      final Response<dynamic> response = await dio.fetch<dynamic>(
        req.copyWith(
          extra: <String, dynamic>{
            ...req.extra,
            '__retry_attempt': nextAttempt,
          },
        ),
      );
      return handler.resolve(response);
    } catch (e) {
      return handler.next(err);
    }
  }
}
