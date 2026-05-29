import 'package:freezed_annotation/freezed_annotation.dart';
part 'failure.freezed.dart';

/// Lớp lỗi sealed duy nhất được truyền từ Repository/Service lên BLoC/UI.
///
/// **Các variant và khi nào dùng:**
/// - `Failure.server(msg)` — lỗi từ API (HTTP 4xx/5xx) hoặc logic server.
///   Dùng khi server trả về response lỗi có nội dung rõ ràng.
/// - `Failure.network(msg)` — mất kết nối, timeout, DNS fail.
///   Thường được tạo tự động bởi [mapDioErrorToFailure].
/// - `Failure.cache(msg)` — đọc/ghi Hive hoặc SecureStorage thất bại.
/// - `Failure.message(msg)` — lỗi tùy ý, hiển thị thẳng cho user
///   (ví dụ: "Đã đạt giới hạn sử dụng hôm nay").
///
/// **Cách dùng trong BLoC:**
/// ```dart
/// result.fold(
///   (failure) => emit(SomeErrorState(failure.displayMessage)),
///   (data)    => emit(SomeLoadedState(data)),
/// );
/// ```
///
/// **Cách kiểm tra loại failure nếu cần xử lý riêng:**
/// ```dart
/// if (failure is NetworkFailure) { /* show offline banner */ }
/// if (failure is ServerFailure)  { /* show retry button  */ }
/// ```
///
/// **Không import `failures.dart`** — file đó là legacy đã bị xóa.
/// Luôn import `failure.dart` (file này).
@freezed
sealed class Failure with _$Failure {
  const factory Failure.server([
    @Default('Server error occurred') String message,
  ]) = ServerFailure;

  const factory Failure.cache([
    @Default('Cache error occurred') String message,
  ]) = CacheFailure;

  const factory Failure.network([
    @Default('Network error occurred') String message,
  ]) = NetworkFailure;

  /// Dùng khi muốn hiển thị thẳng nội dung `message` lên UI mà không cần
  /// phân loại kỹ (ví dụ: thông báo giới hạn freemium, validation nội bộ).
  const factory Failure.message(String message) = MessageFailure;
}

/// Trả về chuỗi phù hợp để hiển thị trực tiếp trên UI (SnackBar, dialog...).
/// Tránh switch thủ công trên Failure ở mọi nơi — dùng getter này.
extension FailureMessage on Failure {
  String get displayMessage => switch (this) {
        ServerFailure(:final message) => message,
        CacheFailure(:final message) => message,
        NetworkFailure(:final message) => message,
        MessageFailure(:final message) => message,
      };
}
