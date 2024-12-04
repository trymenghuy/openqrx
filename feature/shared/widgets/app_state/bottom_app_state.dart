import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';

class BottomAppState extends StatelessWidget {
  final Widget? icon;
  final String? title;
  final VoidCallback? onTap;
  const BottomAppState({super.key, this.icon, required this.onTap, this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red,
      shape: const StadiumBorder(),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          icon ?? const SizedBox(),
          Expanded(
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  child: Text(
                    title ?? 'Something is wrong',
                    style: xStyle.titleLarge?.copyWith(color: xColor.onPrimary),
                  ))),
          IconButton(
              onPressed: onTap,
              icon: const Icon(Icons.close, color: Colors.white))
        ],
      ),
    );
  }
}
