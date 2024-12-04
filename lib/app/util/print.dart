import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(
      methodCount: 1, excludePaths: ['package:openqrx/app/util/print.dart']),
);
void xPrint(Object? message, {bool error = false, bool warn = false}) {
  if (kDebugMode) {
    if (error) {
      logger.e('$message');
    } else if (warn) {
      // print('normal -------------------$message');
      logger.w('$message');
    } else {
      // print('normal -------------------$message');
      logger.i('$message');
    }
  }
}
