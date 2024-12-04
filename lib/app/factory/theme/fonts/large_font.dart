import 'package:flutter/material.dart';
import 'package:openqrx/app/factory/theme/font_factory.dart';

class LargeFont implements AppFont {
  @override
  TextTheme generate() {
    return const TextTheme(
      labelSmall: TextStyle(fontSize: 13),
      labelMedium: TextStyle(fontSize: 14),
      labelLarge: TextStyle(fontSize: 17),
      bodySmall: TextStyle(fontSize: 14),
      bodyMedium: TextStyle(fontSize: 16),
      bodyLarge: TextStyle(fontSize: 17),
      titleSmall: TextStyle(fontSize: 16),
      titleMedium: TextStyle(fontSize: 18),
      titleLarge: TextStyle(fontSize: 22),
      headlineSmall: TextStyle(fontSize: 26),
      headlineMedium: TextStyle(fontSize: 30),
      headlineLarge: TextStyle(fontSize: 34),
      displaySmall: TextStyle(fontSize: 38),
      displayMedium: TextStyle(fontSize: 48),
      displayLarge: TextStyle(fontSize: 60),
    );
  }
}
