import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';

class BackgroundButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onTap;
  const BackgroundButton({super.key, this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
          backgroundColor: xColor.primary,
          foregroundColor: xColor.onPrimary,
          // minimumSize: const Size.fromHeight(50),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap),
      onPressed: onTap,
      child: Text(
        text ?? 'Continue',
        style: xStyle.titleSmall,
      ),
    );
  }
}
