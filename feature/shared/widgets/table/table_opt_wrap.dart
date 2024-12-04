import 'package:flutter/material.dart';

class TableOptWrap extends StatelessWidget {
  final List<Widget> children;
  final List<PopupMenuItem> options;

  const TableOptWrap(
      {super.key, required this.children, required this.options});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: PopupMenuButton(itemBuilder: (_) {
            return options;
          }),
        ),
      ],
    );
  }
}
