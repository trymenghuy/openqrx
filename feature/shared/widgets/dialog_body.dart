import 'package:flutter/material.dart';

class DialogBody extends StatelessWidget {
  final List<Widget> children;
  const DialogBody({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}
