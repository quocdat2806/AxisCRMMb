import 'package:dio/dio.dart';
import 'package:axis_crm/core/config/app_config.dart';
import 'package:axis_crm/core/services/secure_service.dart';
import 'auth_header_interceptor.dart';
import 'logging_interceptor.dart';
import 'network_guard_interceptor.dart';
import 'network_info.dart';
import 'retry_interceptor.dart';

/// Base abstraction cho mọi Dio instance trong app.
///
/// Có hai implementation:
/// - [TranslationDio] — gọi backend riêng, dùng JWT từ SecureStorage.
/// - [OpenAiDio]      — gọi trực tiếp OpenAI API, dùng API key trong header.
///
/// Cả hai đều được inject vào [OpenAiApiClient] thông qua interface này,
/// tách biệt config mạng khỏi tầng service.
abstract class AppDio {
  Dio get dio;
}

/// Dio dành cho backend riêng (JWT auth).
///
/// Interceptor chain (theo thứ tự thực thi):
/// 1. [NetworkGuardInterceptor] — chặn ngay nếu offline, ném NetworkFailure.
/// 2. [AuthHeaderInterceptor]   — đọc JWT từ SecureStorage, gắn vào header.
/// 3. [RetryInterceptor]        — retry tối đa 3 lần khi timeout / 5xx.
/// 4. [LoggingInterceptor]      — log cuối cùng sau khi chain đã xử lý xong.
///
/// Thứ tự quan trọng: Guard phải đứng trước Auth để không đọc storage vô nghĩa
/// khi đã biết offline. Logging đứng cuối để thấy header đầy đủ sau khi Auth thêm vào.
class TranslationDio extends AppDio {
  TranslationDio({
    required NetworkInfo networkInfo,
    required SecureStorageService secure,
    required LoggingInterceptor logging,
  }) : _networkInfo = networkInfo,
       _secure = secure,
       _logging = logging {
    _dio = _build();
  }

  final NetworkInfo _networkInfo;
  final SecureStorageService _secure;
  final LoggingInterceptor _logging;
  late final Dio _dio;

  @override
  Dio get dio => _dio;

  Dio _build() {
    final Dio d = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseOpenAiUrl,
        headers: const <String, dynamic>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        connectTimeout: const Duration(milliseconds: AppConfig.connectTimeout),
        receiveTimeout: const Duration(milliseconds: AppConfig.receiveTimeout),
      ),
    );

    final RetryInterceptor retry = RetryInterceptor(
      dio: d,
      retryAbleStatusCodes: const <int>{502, 503, 504},
      retryMethods: const <String>{'GET', 'PUT', 'DELETE', 'HEAD', 'OPTIONS'},
    );

    d.interceptors.addAll(<Interceptor>[
      NetworkGuardInterceptor(networkInfo: _networkInfo),
      AuthHeaderInterceptor(secure: _secure),
      retry,
      _logging,
    ]);

    return d;
  }
}

/// Dio dành riêng cho OpenAI API.
///
/// API key được set cứng trong [BaseOptions.headers] lúc khởi tạo —
/// không dùng [AuthHeaderInterceptor] vì interceptor đó đọc JWT của backend,
/// còn OpenAI dùng scheme `Bearer <api-key>` khác hoàn toàn.
///
/// Interceptor chain (theo thứ tự thực thi):
/// 1. [NetworkGuardInterceptor] — chặn nếu offline.
/// 2. [RetryInterceptor]        — retry timeout / 502-504.
/// 3. [LoggingInterceptor]      — log sau khi chain xử lý xong.
///
/// [LoggingInterceptor] được inject từ DI (singleton dùng chung với
/// [TranslationDio]) để tránh tạo nhiều instance thừa.
