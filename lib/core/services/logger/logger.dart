import 'package:logger/logger.dart';

class _CustomLogger extends LogPrinter {
  final dynamic className;

  _CustomLogger(this.className);

  @override
  List<String> log(LogEvent event) {
    String? emoji = PrettyPrinter.defaultLevelEmojis[event.level];
    AnsiColor? color = PrettyPrinter.defaultLevelColors[event.level];

    return [color!('$emoji $className - ${event.message}')];
  }
}

class Log {
  /// info level
  Log(final dynamic runtimeType, dynamic message) {
    Logger(printer: _CustomLogger(runtimeType)).i(
      message,
    );
  }

  /// debug level
  Log.d(final dynamic runtimeType, dynamic message) {
    Logger(printer: _CustomLogger(runtimeType)).d(message);
  }

  /// error level
  Log.e(final dynamic runtimeType, dynamic message, [StackTrace? stackTrace]) {
    if (stackTrace != null) {
      Logger(printer: _CustomLogger(runtimeType)).e('$message\n$stackTrace');
      return;
    }

    Logger(printer: _CustomLogger(runtimeType)).e(message);
  }

  /// trace level
  Log.t(final dynamic runtimeType, dynamic message) {
    Logger(printer: _CustomLogger(runtimeType)).t(message);
  }

  /// warning level
  Log.w(final dynamic runtimeType, dynamic message) {
    Logger(printer: _CustomLogger(runtimeType)).w(message);
  }

  /// info level
  Log.i(final dynamic runtimeType, dynamic message) {
    Logger(printer: _CustomLogger(runtimeType)).i(message);
  }

  /// fatal level
  Log.f(final dynamic runtimeType, dynamic message) {
    Logger(printer: _CustomLogger(runtimeType)).f(message);
  }
}
