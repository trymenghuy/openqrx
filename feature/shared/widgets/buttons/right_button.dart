import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';

class RightButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onTap;
  const RightButton(
      {super.key, required this.text, this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      icon: icon == null ? null : Icon(icon, size: x20),
      style: FilledButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: radiusMedium),
      ),
      onPressed: onTap,
      label: Text(text),
    );
  }
}
