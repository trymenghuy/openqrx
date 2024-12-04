import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/enum/e_button_color.dart';

class SmallButton extends StatelessWidget {
  final String? text;
  final Widget? icon;
  final VoidCallback? onTap;
  final bool float;
  final EButtonColor eColor;
  const SmallButton(
      {super.key,
      this.text,
      this.onTap,
      this.float = false,
      this.icon,
      this.eColor = EButtonColor.error});
  @override
  Widget build(BuildContext context) {
    final color = EButtonColor.getColors(eColor);
    final child = Text(
      text ?? 'Continue',
      style: xStyle.labelMedium?.copyWith(color: color.color),
    );
    final isIcon = icon != null;
    return MaterialButton(
      height: 30,
      minWidth: 60,
      elevation: 0,
      color: color.background,
      textColor: color.color,
      onPressed: onTap,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.symmetric(horizontal: x10),
      shape: const StadiumBorder(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isIcon) ...[icon!, space5],
          child,
          if (isIcon) space5,
        ],
      ),
    );
  }
}
