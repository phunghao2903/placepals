import 'dart:developer' as developer;

class AppLogger {
  void info(String message, {String name = 'PlacePals'}) {
    developer.log(message, name: name);
  }

  void warn(String message, {String name = 'PlacePals'}) {
    developer.log(message, name: name, level: 900);
  }

  void error(String message, {String name = 'PlacePals', Object? error, StackTrace? stackTrace}) {
    developer.log(
      message,
      name: name,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
