import 'package:flutter/material.dart';

class FullAppState extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  const FullAppState({super.key, required this.child, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: Container(
      color: Colors.white,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        child,
        TextButton(onPressed: onTap, child: const Text('Button')),
      ]),
    ));
  }
}
