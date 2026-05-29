import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

final appLogger = AppLogger._();

class AppLogger {
  AppLogger._();

  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      errorMethodCount: 5,
      lineLength: 150,
    ),
    level: kReleaseMode ? Level.warning : Level.debug,
  );

  void d(dynamic message) => _logger.d(message);
  void i(dynamic message) => _logger.i(message);
  void w(dynamic message) => _logger.w(message);
  void e(dynamic message, [StackTrace? stackTrace]) =>
      _logger.e(message, stackTrace: stackTrace);
}
