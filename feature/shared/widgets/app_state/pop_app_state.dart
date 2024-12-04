import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';

class PopAppState extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final String? button;
  final String? title;
  final bool showIp;
  const PopAppState(
      {super.key,
      required this.child,
      this.onTap,
      this.button,
      this.title,
      this.showIp = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black45,
      alignment: Alignment.center,
      child: AlertDialog(
        content: child,
        actions: [
          if (onTap != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextButton(
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      backgroundColor: xColor.primary,
                      foregroundColor: xColor.onPrimary,
                      minimumSize: const Size.fromHeight(40)),
                  onPressed: onTap,
                  child: Text(button ?? 'Okay')),
            ),
        ],
      ),
    );
  }
}
