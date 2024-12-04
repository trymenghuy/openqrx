import 'package:flutter/material.dart';
import 'package:openqrx/app/factory/theme/color_factory.dart';

class DarkColor implements AppColor {
  @override
  ColorScheme generate() {
    return ColorScheme.fromSeed(
      seedColor: const Color(0xff5db3d5),
      brightness: Brightness.dark,
    );
  }
}
