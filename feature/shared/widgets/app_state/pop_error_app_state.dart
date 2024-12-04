import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';

class PopErrorAppState extends StatelessWidget {
  final String? text;
  final List<Widget>? actions;
  const PopErrorAppState(
      {super.key, required this.actions, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black45,
      alignment: Alignment.center,
      child: button.dialog(
          title: txt.error_occurred,
          children: [Text(text ?? txt.unknown_error)],
          actions: actions),
    );
  }
}
