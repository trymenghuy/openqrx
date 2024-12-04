import 'package:flutter/services.dart';
import 'package:openqrx/app/util/print.dart';

class NativeMethod {
  static const platform = MethodChannel('trymenghuy');
  static NativeMethod? _instance;

  // Private constructor
  NativeMethod._();

  // Singleton instance getter
  static NativeMethod get instance {
    _instance ??= NativeMethod._();
    return _instance!;
  }

  Future<String?> getDeviceId() async {
    try {
      return await platform.invokeMethod('getDeviceId');
    } on PlatformException catch (e) {
      xPrint('error-getDeviceId ${e.message}');
    }
    return null;
  }
}
