import 'package:flutter/material.dart';
import 'package:openqrx/app/factory/theme/font_factory.dart';

class MediumFont implements AppFont {
  @override
  TextTheme generate() {
    return const TextTheme(
      labelSmall: TextStyle(fontSize: 11),
      labelMedium: TextStyle(fontSize: 13),
      labelLarge: TextStyle(fontSize: 15),
      bodySmall: TextStyle(fontSize: 12),
      bodyMedium: TextStyle(fontSize: 14),
      bodyLarge: TextStyle(fontSize: 16),
      titleSmall: TextStyle(fontSize: 14),
      titleMedium: TextStyle(fontSize: 17),
      titleLarge: TextStyle(fontSize: 20),
      headlineSmall: TextStyle(fontSize: 24),
      headlineMedium: TextStyle(fontSize: 28),
      headlineLarge: TextStyle(fontSize: 32),
      displaySmall: TextStyle(fontSize: 36),
      displayMedium: TextStyle(fontSize: 45),
      displayLarge: TextStyle(fontSize: 57),
    );
  }
}
