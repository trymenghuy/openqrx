import 'package:flutter/material.dart';

class LoadMore extends StatelessWidget {
  final Widget child;
  final VoidCallback onMore;
  final VoidCallback? onTop;

  const LoadMore(
      {super.key, required this.child, required this.onMore, this.onTop});

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollEndNotification) {
            final current = notification.metrics.extentBefore;
            final max = notification.metrics.maxScrollExtent;
            if (max - current < 100) {
              onMore();
            } else if (current < 200) {
              onTop?.call();
            }
          }
          return false;
        },
        child: child);
  }
}
