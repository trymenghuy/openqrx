import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/enum/e_button_color.dart';

class LongButton extends StatelessWidget {
  final String? text;
  final Widget? icon;
  final VoidCallback? onTap;
  final bool float;
  final EButtonColor color;
  const LongButton(
      {super.key,
      this.text,
      this.onTap,
      this.float = false,
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
        ? TextButton(
            style: EButtonColor.getStyle(color),
            onPressed: onTap,
            child: child,
          )
        : TextButton.icon(
            icon: icon!,
            style: EButtonColor.getStyle(color),
            onPressed: onTap,
            label: child,
          );
    // if (float) {
    //   return Padding(
    //       padding: MediaQuery.of(context).viewInsets, child: textButton);
    // }
    return textButton;
  }
}
