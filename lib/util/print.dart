import 'package:flutter/foundation.dart';

class Print {
  static regular(dynamic text) {
    if (kDebugMode) print(text.toString());
  }

  static debug(dynamic text) {
    if (kDebugMode) print('\x1B[35m${text.toString()}\x1B[0m');
  }

  static warning(dynamic text) {
    if (kDebugMode) print('\x1B[33m${text.toString()}\x1B[0m');
  }

  static error(dynamic text) {
    if (kDebugMode) print('\x1B[31m${text.toString()}\x1B[0m');
  }

  static success(dynamic text) {
    if (kDebugMode) print('\x1B[32m${text.toString()}\x1B[0m');
  }

  static info(dynamic text) {
    if (kDebugMode) print('\x1B[36m${text.toString()}\x1B[0m');
  }
}
