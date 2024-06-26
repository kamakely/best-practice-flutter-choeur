import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LoggerUtils {
  static final logger =
      Logger(printer: PrettyPrinter(methodCount: 0), filter: DemoFilter());
  static void trace(String logText) => logger.t(logText);
  static void debug(String logText) => logger.d(logText);
  static void info(String logText) => logger.i(logText);
  static void warning(String logText) => logger.w(logText);
  static void error(String logText) => logger.e(logText);
  static void fatalError(String logText) => logger.f(logText);
}

class DemoFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return kDebugMode;
  }
}