import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String text;
  final Widget svg;
  final VoidCallback onTap;
  const DrawerTile(
      {super.key, required this.text, required this.svg, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: svg,
      title: Text(text),
      onTap: () async {
        Navigator.pop(context);
        await Future.delayed(const Duration(milliseconds: 200));
        onTap();
      },
    );
  }
}
