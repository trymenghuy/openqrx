import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';

class RemoveNestedIcon extends StatelessWidget {
  final VoidCallback onTap;
  const RemoveNestedIcon({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: SizedBox(
            width: 36,
            height: 36,
            child: Icon(
              Icons.remove_circle,
              color: xColor.error,
              size: 18,
            )));
  }
}
