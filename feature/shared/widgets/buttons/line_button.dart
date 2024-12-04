import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/enum/e_button_color.dart';

class LineButton extends StatelessWidget {
  final String? text;
  final Widget? icon;
  final VoidCallback? onTap;
  final EButtonColor color;
  const LineButton(
      {super.key,
      this.text,
      this.onTap,
      this.icon,
      this.color = EButtonColor.primary});

  @override
  Widget build(BuildContext context) {
    final child = Text(
      text ?? 'Continue',
      style: xStyle.titleMedium?.copyWith(
          color: onTap == null ? xColor.primaryContainer : xColor.onPrimary),
    );
    final textButton = icon == null
        ? OutlinedButton(
            // style: EButtonColor.getStyle(color),
            onPressed: onTap,
            child: child,
          )
        : OutlinedButton.icon(
            icon: icon!,
            // style: EButtonColor.getStyle(color),
            onPressed: onTap,
            label: child,
          );
    return textButton;
  }
}
