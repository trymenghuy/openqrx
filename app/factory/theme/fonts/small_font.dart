import 'package:flutter/material.dart';
import 'package:openqrx/app/factory/theme/font_factory.dart';

class SmallFont implements AppFont {
  @override
  TextTheme generate() {
    return const TextTheme(
      labelSmall: TextStyle(fontSize: 9),
      labelMedium: TextStyle(fontSize: 10),
      labelLarge: TextStyle(fontSize: 13),
      bodySmall: TextStyle(fontSize: 10),
      bodyMedium: TextStyle(fontSize: 12),
      bodyLarge: TextStyle(fontSize: 13),
      titleSmall: TextStyle(fontSize: 12),
      titleMedium: TextStyle(fontSize: 14),
      titleLarge: TextStyle(fontSize: 18),
      headlineSmall: TextStyle(fontSize: 22),
      headlineMedium: TextStyle(fontSize: 26),
      headlineLarge: TextStyle(fontSize: 30),
      displaySmall: TextStyle(fontSize: 34),
      displayMedium: TextStyle(fontSize: 42),
      displayLarge: TextStyle(fontSize: 54),
    );
  }
}
