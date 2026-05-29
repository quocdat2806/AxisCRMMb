import 'package:dio/dio.dart';
import 'package:axis_crm/core/config/app_config.dart';
import 'package:axis_crm/core/services/secure_service.dart';

/// Gắn JWT Bearer token vào header `Authorization` của mỗi request.
///
/// Token được đọc từ [SecureStorageService] (flutter_secure_storage) với key
/// [AppConfig.tokenKey]. Nếu token chưa có (chưa login) thì bỏ qua, không
/// block request.
///
/// Chỉ dùng cho [TranslationDio] (backend riêng dùng JWT).
/// **Không** dùng cho [OpenAiDio] — OpenAI key được set cứng trong
/// [BaseOptions.headers] khi khởi tạo Dio.
class AuthHeaderInterceptor extends Interceptor {
  AuthHeaderInterceptor({required this.secure});
  final SecureStorageService secure;

  static const String _key = AppConfig.tokenKey;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? token = await secure.read(_key);
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
