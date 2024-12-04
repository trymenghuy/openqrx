import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';

// class BaseText extends StatelessWidget {
//   final String text;
//   final Color? color;
//   final TextStyle? style;

//   const BaseText(this.text, {super.key, this.color, required this.style});

//   @override
//   Widget build(BuildContext context) {
//     return Text(text, style: style?.copyWith(color: color));
//   }
// }
class BaseText extends Text {
  BaseText(super.text, {Color? color, TextStyle? style, super.key})
      : super(style: style?.copyWith(color: color));
}

class TitleSm extends BaseText {
  TitleSm(super.text, {super.key, super.color})
      : super(style: xStyle.titleSmall);
}

class TitleMd extends BaseText {
  TitleMd(super.text, {super.key, super.color})
      : super(style: xStyle.titleMedium);
}

class TitleLg extends BaseText {
  TitleLg(super.text, {super.key, super.color})
      : super(style: xStyle.titleLarge);
}

class SubTitleSm extends BaseText {
  SubTitleSm(super.text, {super.key})
      : super(style: xStyle.bodySmall, color: xColor.outline);
}

class SubTitleMd extends BaseText {
  SubTitleMd(super.text, {super.key})
      : super(style: xStyle.bodyMedium, color: xColor.outline);
}

class SubTitleLg extends BaseText {
  SubTitleLg(super.text, {super.key})
      : super(style: xStyle.bodyLarge, color: xColor.outline);
}
