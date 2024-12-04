import 'package:flutter/material.dart';
import 'package:openqrx/app/factory/theme/color_factory.dart';

class LightColor implements AppColor {
  @override
  ColorScheme generate() {
    return ColorScheme.fromSeed(
      seedColor: const Color(0xff35a0cb),
    );
  }
}
