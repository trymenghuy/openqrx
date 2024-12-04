import 'package:flutter/material.dart';
import 'package:openqrx/app/factory/theme/font_factory.dart';

class ExtraLargeFont implements AppFont {
  @override
  TextTheme generate() {
    return const TextTheme(
      labelSmall: TextStyle(fontSize: 15),
      labelMedium: TextStyle(fontSize: 16),
      labelLarge: TextStyle(fontSize: 19),
      bodySmall: TextStyle(fontSize: 16),
      bodyMedium: TextStyle(fontSize: 18),
      bodyLarge: TextStyle(fontSize: 19),
      titleSmall: TextStyle(fontSize: 18),
      titleMedium: TextStyle(fontSize: 20),
      titleLarge: TextStyle(fontSize: 24),
      headlineSmall: TextStyle(fontSize: 30),
      headlineMedium: TextStyle(fontSize: 36),
      headlineLarge: TextStyle(fontSize: 40),
      displaySmall: TextStyle(fontSize: 44),
      displayMedium: TextStyle(fontSize: 54),
      displayLarge: TextStyle(fontSize: 72),
    );
  }
}
