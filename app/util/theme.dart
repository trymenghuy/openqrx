import 'package:flutter/material.dart';
import 'package:openqrx/app/factory/theme/font_factory.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/enum/ln.dart';
import 'package:openqrx/domain/enum/size_font.dart';

ThemeData buildTheme(ColorScheme color, SizeFont font, LN ln) {
  final textTheme = AppFont(font).generate();
  // final textTheme = const TextTheme().apply(fontSizeFactor: font.value);
  final fontFamily = ln == LN.km ? 'Koh Santepheap' : null;
  // xPrint('fontFamily $fontFamily');
  return ThemeData(
      useMaterial3: true,
      colorScheme: color,
      textTheme: const TextTheme().apply(fontSizeFactor: font.value),

      // fontFamily: fontFamily,
      typography: Typography.material2021(),
      appBarTheme: AppBarTheme(
          // elevation: 4,
          titleTextStyle:
              textTheme.headlineSmall?.copyWith(color: color.onSurface)),
      badgeTheme: const BadgeThemeData(
          backgroundColor: xRed, offset: Offset.zero, textColor: xWhite),
      dividerTheme: DividerThemeData(
          space: x0,
          thickness: 0.25,
          indent: x15,
          endIndent: x15,
          color: color.outline),
      listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(borderRadius: radiusSmall)),
      snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.fixed),
      cardTheme: CardTheme(
          elevation: 1,
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.25, color: color.tertiary),
              borderRadius: radiusMedium),
          margin: const EdgeInsets.symmetric(horizontal: x10, vertical: x5)),
      chipTheme: ChipThemeData(
          labelStyle: textTheme.labelMedium, shape: const StadiumBorder()));
}
