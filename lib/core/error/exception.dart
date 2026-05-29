// Exception tầng thấp chỉ ném trong Repository/Service, không để lọt lên
// tầng BLoC/UI.
//
// Luồng biến đổi:
// ```
// throw ServerException(...)
//   → bị bắt trong guardFuture/guardSync
//   → chuyển thành left(ServerFailure(...))
//   → BLoC nhận Either và xử lý
// ```
//
// Nếu code đang ở tầng service/repository và trả về EitherFailureOr<T> thì dùng
// `return left(ServerFailure(...))` trực tiếp, không cần ném Exception.

/// Lỗi từ server (HTTP 4xx/5xx, parse JSON thất bại, logic nghiệp vụ).
class ServerException implements Exception {
  const ServerException({this.message = 'Server error occurred'});
  final String message;

  @override
  String toString() => 'ServerException: $message';
}

/// Lỗi đọc/ghi local storage (Hive, SecureStorage).
class CacheException implements Exception {
  const CacheException({this.message = 'Cache error occurred'});
  final String message;

  @override
  String toString() => 'CacheException: $message';
}

/// Lỗi kết nối mạng (timeout, DNS, không có internet).
/// Thường được ném bởi [NetworkGuardInterceptor] thông qua DioException,
/// nhưng có thể ném thủ công nếu cần kiểm tra network ngoài Dio.
class NetworkException implements Exception {
  const NetworkException({this.message = 'Network error occurred'});
  final String message;

  @override
  String toString() => 'NetworkException: $message';
}
