import 'package:flutter/material.dart';

class OffsetPop extends StatelessWidget {
  final Widget child;
  final Widget? clear;
  final Function(BuildContext, Offset) onTab;
  final double top;
  const OffsetPop(
      {super.key,
      required this.child,
      required this.onTab,
      this.clear,
      this.top = 12});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        onTab(context, details.globalPosition);
      },
      child: Stack(
        children: [
          child,
          if (clear != null)
            Positioned(
              right: 0,
              top: top,
              child: clear!,
            ),
        ],
      ),
    );
  }
}
