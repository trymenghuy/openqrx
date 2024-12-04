// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';

enum EButtonColor {
  primary('primary'),
  error('error');

  const EButtonColor(this.value);
  final String value;
  static ButtonStyle getStyle(EButtonColor color) {
    Color? backgroundColor;
    Color? foregroundColor;
    switch (color) {
      case EButtonColor.primary:
        backgroundColor = xColor.primary;
        foregroundColor = xColor.onPrimary;
        break; // Add break statement here
      case EButtonColor.error:
        backgroundColor = xColor.error;
        foregroundColor = xColor.onError;
        break; // Add break statement here
    }
    return TextButton.styleFrom(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      iconColor: foregroundColor,
      minimumSize: const Size.fromHeight(kTextTabBarHeight),
      shape: RoundedRectangleBorder(borderRadius: radiusSmall),
      padding: const EdgeInsets.symmetric(horizontal: x15, vertical: x10),
    );
  }

  static BackFrontColor getColors(EButtonColor color) {
    switch (color) {
      case EButtonColor.primary:
        return BackFrontColor(
            xColor.onPrimaryContainer, xColor.primaryContainer);
      case EButtonColor.error:
        return BackFrontColor(
            xColor.secondaryContainer, xColor.onSecondaryContainer);
    }
  }

  factory EButtonColor.fromString(String? ln) => EButtonColor.values
      .firstWhere((e) => e.value == ln, orElse: () => EButtonColor.primary);
}

class BackFrontColor {
  final Color color;
  final Color background;
  BackFrontColor(this.color, this.background);
}
