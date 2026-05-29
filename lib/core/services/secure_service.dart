import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Wrapper singleton quanh [FlutterSecureStorage] — lưu dữ liệu nhạy cảm
/// (JWT token, API key dự phòng...) vào Keychain (iOS) / Keystore (Android).
///
/// Singleton được đảm bảo bằng factory constructor, không cần đăng ký vào DI
/// như lazy singleton — có thể gọi `SecureStorageService()` trực tiếp từ bất cứ đâu.
///
/// Key convention: dùng hằng số từ [AppConfig] để tránh magic string:
/// ```dart
/// await secure.write(AppConfig.tokenKey, jwt);
/// final token = await secure.read(AppConfig.tokenKey);
/// ```
///
/// Được inject vào [AuthHeaderInterceptor] để tự động đính JWT vào mọi
/// request của [TranslationDio].
class SecureStorageService {
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();
  static final SecureStorageService _instance =
      SecureStorageService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);
  Future<String?> read(String key) => _storage.read(key: key);
  Future<void> delete(String key) => _storage.delete(key: key);

  /// Xóa toàn bộ — dùng khi logout, không phải reset setting thông thường.
  Future<void> deleteAll() => _storage.deleteAll();
}
