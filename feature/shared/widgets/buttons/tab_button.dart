import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';

class TabButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String text;
  final IconData icon;
  const TabButton(
      {super.key, this.onTap, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: const EdgeInsets.symmetric(horizontal: x10),
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: x10),
        constraints: const BoxConstraints(minWidth: 80),
        child: Tab(
          height: 90,
          icon: CircleAvatar(
            radius: 30,
            backgroundColor: chipColor,
            child: Icon(icon, size: 30),
          ),
          child: Text(text, style: xStyle.labelMedium),
        ),
      ),
    );
  }
}
