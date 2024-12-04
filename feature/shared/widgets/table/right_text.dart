import 'package:flutter/material.dart';

class RightText extends StatelessWidget {
  final String text;
  const RightText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: FittedBox(
          fit: BoxFit.fitWidth,
          child: Text(text),
        ));
  }
}
