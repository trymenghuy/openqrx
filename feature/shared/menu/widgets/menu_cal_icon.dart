import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';

class MenuCalIcon extends StatelessWidget {
  final bool plus;
  final VoidCallback? onTap;
  const MenuCalIcon({super.key, required this.plus, this.onTap});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      minWidth: 44,
      padding: EdgeInsets.zero,
      elevation: 0,
      color: xColor.surfaceContainerHigh,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
              right: plus ? const Radius.circular(x20) : Radius.zero,
              left: plus ? Radius.zero : const Radius.circular(x20))),
      height: 40,
      child: Icon(plus ? Icons.add : Icons.remove, size: 20
          // color: xColor.onSecondaryContainer,
          ),
    );
  }
}
