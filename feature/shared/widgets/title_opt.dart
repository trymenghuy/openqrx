import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';

class TitleOpt extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const TitleOpt(this.text, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            child: Text(
          text,
          style: style,
        )),
        Icon(
          Icons.arrow_drop_down_rounded,
          size: x30,
          color: xColor.primary,
        )
      ],
    );
  }
}
