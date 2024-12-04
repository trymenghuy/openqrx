import 'package:flutter/material.dart';
import 'package:openqrx/app/factory/theme/fonts/extra_large_font.dart';
import 'package:openqrx/app/factory/theme/fonts/large_font.dart';
import 'package:openqrx/app/factory/theme/fonts/medium_font.dart';
import 'package:openqrx/app/factory/theme/fonts/small_font.dart';
import 'package:openqrx/domain/enum/size_font.dart';

abstract class AppFont {
  factory AppFont(SizeFont mode) {
    // final TextScaler textScaler = MediaQuery.textScalerOf(context);
    // const double baseFontSize = 20;
    // final double scaledFontSize = textScaler.scale(baseFontSize);
    switch (mode) {
      case SizeFont.small:
        return SmallFont();
      case SizeFont.normal:
        return MediumFont();
      case SizeFont.large:
        return LargeFont();
      case SizeFont.extraLarge:
        return ExtraLargeFont();
    }
  }

  TextTheme generate();
}
