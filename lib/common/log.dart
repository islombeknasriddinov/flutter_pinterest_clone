import 'package:flutter/foundation.dart';

class Logger {
  static void e([dynamic e, dynamic st]) {
    if (kDebugMode) {
      print("Error : $e, stacktrace : $st");
    }
  }
}
