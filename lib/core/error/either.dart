import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'error_mapper.dart';
import 'exception.dart';
import 'failure.dart';

/// Kiểu trả về chuẩn cho mọi Repository và Service trong app.
///
/// `left(Failure)` — có lỗi, BLoC xử lý với `.fold((f) => ..., (_) => ...)`.
/// `right(T)`      — thành công, BLoC lấy giá trị từ `.fold((_, v) => ...)`.
///
/// Ví dụ khai báo hàm trong repository:
/// ```dart
/// Future<EitherFailureOr<List<Word>>> fetchWords();
/// ```
typedef EitherFailureOr<T> = Either<Failure, T>;

/// Bọc một async block và tự động bắt mọi loại exception về [Failure].
///
/// Thứ tự ưu tiên bắt lỗi:
/// 1. `Failure` ném thẳng → giữ nguyên.
/// 2. `DioException` → [mapDioErrorToFailure] (network/server tùy status code).
/// 3. `ServerException` / `CacheException` / `NetworkException` → Failure tương ứng.
/// 4. Bất kỳ lỗi khác → `ServerFailure(e.toString())` (fallback an toàn).
///
/// Dùng trong mọi repository/service gọi network hoặc IO async:
/// ```dart
/// Future<EitherFailureOr<String>> translate(String text) =>
///     guardFuture(() async {
///       final res = await _client.post(path: OpenAiEndpoints.chatCompletions, data: {...});
///       return res.data['choices'][0]['message']['content'] as String;
///     });
/// ```
Future<EitherFailureOr<T>> guardFuture<T>(Future<T> Function() run) async {
  try {
    final T result = await run();
    return right(result);
  } on Failure catch (f) {
    return left(f);
  } on DioException catch (e) {
    return left(mapDioErrorToFailure(e));
  } on ServerException catch (e) {
    return left(ServerFailure(e.message));
  } on CacheException catch (e) {
    return left(CacheFailure(e.message));
  } on NetworkException catch (e) {
    return left(NetworkFailure(e.message));
  } catch (e) {
    return left(ServerFailure(e.toString()));
  }
}

/// Phiên bản đồng bộ của [guardFuture] — dùng cho các thao tác không async
/// như đọc Hive box, parse JSON local, hoặc tính toán có thể ném exception.
///
/// ```dart
/// EitherFailureOr<UserProfile> loadProfile() =>
///     guardSync(() => _box.get('profile') ?? (throw CacheException()));
/// ```
EitherFailureOr<T> guardSync<T>(T Function() run) {
  try {
    final T result = run();
    return right(result);
  } on Failure catch (f) {
    return left(f);
  } on CacheException catch (e) {
    return left(CacheFailure(e.message));
  } on NetworkException catch (e) {
    return left(NetworkFailure(e.message));
  } on ServerException catch (e) {
    return left(ServerFailure(e.message));
  } catch (e) {
    return left(ServerFailure(e.toString()));
  }
}
