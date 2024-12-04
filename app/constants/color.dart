import 'package:flutter/cupertino.dart';

class YColor {
  final Color background;
  final Color text;
  final Color link = CupertinoColors.link;

  YColor({
    required this.background,
    required this.text,
  });
}

Map<Brightness, YColor> brightColor = {
  Brightness.light: YColor(
    background: const Color(0xffdddddd),
    text: const Color(0xff222222),
  ),
  Brightness.dark: YColor(
    background: const Color(0xff444444),
    text: const Color(0xffeeeeee),
  ),
};
