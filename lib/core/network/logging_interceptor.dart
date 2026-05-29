import 'package:dio/dio.dart';
import 'package:axis_crm/core/utils/logger.dart';

/// Log toàn bộ request/response/error qua [appLogger].
///
/// - Header `Authorization` bị mask thành `Bearer ***` trước khi log —
///   tránh lộ token trong console hay crash report.
/// - Body bị cắt ở [maxBody] bytes (mặc định 15 KB) để không làm chậm console
///   khi response lớn (ví dụ stream từ OpenAI).
/// - Dùng `appLogger.d` cho request/response (chỉ hiện ở debug),
///   `appLogger.e` cho error (hiện ở cả release warning+).
///
/// Luôn đặt interceptor này **cuối cùng** trong chain để log được trạng thái
/// sau khi các interceptor khác đã xử lý xong (headers đã được thêm, v.v.).
class LoggingInterceptor extends Interceptor {
  LoggingInterceptor({this.maxBody = 15 * 1024});
  final int maxBody;

  String _truncate(String s) =>
      s.length > maxBody ? '${s.substring(0, maxBody)}…' : s;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final Map<String, dynamic> headers = Map<String, dynamic>.of(
      options.headers,
    );
    if (headers.containsKey('Authorization')) {
      headers['Authorization'] = 'Bearer ***';
    }

    final StringBuffer buf = StringBuffer()
      ..writeln(' ${options.method} ${options.uri}')
      ..writeln(' Headers : $headers');
    if (options.queryParameters.isNotEmpty) {
      buf.writeln('Query: ${options.queryParameters}');
    }
    if (options.data != null) {
      buf.writeln('Body: ${_truncate(options.data.toString())}');
    }
    appLogger.d(buf.toString().trimRight());

    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final StringBuffer buf = StringBuffer()
      ..writeln(
        'SUCCESS ${response.statusCode} ${response.requestOptions.uri}',
      );
    if (response.data != null) {
      buf.writeln('Body: ${_truncate(response.data.toString())}');
    }
    appLogger.d(buf.toString().trimRight());

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final StringBuffer buf = StringBuffer()
      ..writeln(
        'ERROR ${err.type.name} ${err.requestOptions.uri}'
        '${err.response?.statusCode != null ? ' [${err.response!.statusCode}]' : ''}',
      );
    if (err.response?.data != null) {
      buf.writeln('Body: ${_truncate(err.response!.data.toString())}');
    }
    appLogger.e(buf.toString().trimRight());

    handler.next(err);
  }
}
