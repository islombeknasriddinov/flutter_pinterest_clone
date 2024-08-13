import 'package:flutter/foundation.dart';

class Logger {
  static void e([dynamic e, dynamic st]) {
    if (kDebugMode) {
      print("Error : $e \n stacktrace : $st");
    }
  }

  static void p(Object? object) {
    if (kDebugMode) {
      print(object);
    }
  }
}
