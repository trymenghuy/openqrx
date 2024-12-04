import 'package:flutter/material.dart';
import 'package:openqrx/app/factory/theme/colors/dark_color.dart';
import 'package:openqrx/app/factory/theme/colors/green_color.dart';
import 'package:openqrx/app/factory/theme/colors/light_color.dart';
import 'package:openqrx/app/factory/theme/colors/pink_color.dart';
import 'package:openqrx/domain/enum/mode.dart';

abstract class AppColor {
  factory AppColor(Mode mode, BuildContext context) {
    switch (mode) {
      case Mode.light:
        return LightColor();
      case Mode.dark:
        return DarkColor();
      case Mode.system:
        final bright = MediaQuery.of(context).platformBrightness;
        final isDarkMode = bright == Brightness.dark;
        if (isDarkMode) {
          return DarkColor();
        }
        return LightColor();
      case Mode.pink:
        return PinkColor();
      case Mode.green:
        return GreenColor();
    }
  }

  ColorScheme generate();
}
