import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:openqrx/app/constants/color.dart';
import 'package:openqrx/app/factory/component/button.dart';
import 'package:openqrx/app/util/navigator.dart';

AppLocalizations get txt => AppLocalizations.of(XNavigator.context)!;
ThemeData get xTheme => Theme.of(XNavigator.context);
ColorScheme get xColor => xTheme.colorScheme;
TextTheme get xStyle => xTheme.textTheme;
YColor get yColor => brightColor[xTheme.colorScheme.brightness]!;
ColorScheme getColor(BuildContext context) => Theme.of(context).colorScheme;
TextTheme getStyle(BuildContext context) => Theme.of(context).textTheme;
const xRed = CupertinoColors.systemRed;
const xWhite = CupertinoColors.white;
Size get xSize => MediaQuery.of(XNavigator.context).size;
EdgeInsets get xPad => MediaQuery.of(XNavigator.context).padding;
// Brightness get xMode => MediaQuery.of(XNavigator.context).platformBrightness;
late Button button;
const double x300 = 300;
const double x150 = 150;
const double x100 = 100;
const double x60 = 60;
const double x50 = 50;
const double x40 = 40;
const double x30 = 30;
const double x20 = 20;
const double x25 = 25;
const double x15 = 15;
const double x12 = 12.5;
const double x10 = 10;
const double x8 = 8;
const double x5 = 5;
const double x2 = 2;
const double x0 = 0;

late double rate;

Widget space30 = const SizedBox(width: x30, height: x30);
Widget space20 = const SizedBox(width: x20, height: x20);
Widget space15 = const SizedBox(width: x15, height: x15);
Widget space10 = const SizedBox(width: x10, height: x10);
Widget space5 = const SizedBox(width: x5, height: x5);
Widget space2 = const SizedBox(width: x2, height: x2);
Color flagColor(bool? danger) => danger == true
    ? xRed
    : danger == false
        ? CupertinoColors.link
        : CupertinoColors.activeGreen;

BorderRadius radiusMedium = BorderRadius.circular(x10);
const Radius radius10 = Radius.circular(x10);
const Radius radius5 = Radius.circular(x5);
Border get borderBottom => Border(bottom: borderSide05);
BorderRadius radiusSmall = BorderRadius.circular(x2);
BorderRadius radiusBig = BorderRadius.circular(x20);
BorderSide get borderSide => BorderSide(width: 0.25, color: xColor.tertiary);
BorderSide get borderSide05 => BorderSide(width: 0.5, color: xColor.tertiary);
TextStyle? get xGreyStyleSmall =>
    xStyle.bodySmall?.copyWith(color: xColor.outline);
TextStyle? get xGreyStyleMedium =>
    xStyle.bodyMedium?.copyWith(color: xColor.outline);
TextStyle? get xGreyStyleLarge =>
    xStyle.bodyLarge?.copyWith(color: xColor.outline);
Color get chipColor => xColor.surfaceTint.withOpacity(0.2);
Color get onChipColor => xColor.inverseSurface;
