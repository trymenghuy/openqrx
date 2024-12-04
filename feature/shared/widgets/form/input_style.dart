import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';

class InputStyle {
  static border(
      {String? labelText,
      Widget? suffixIcon,
      String? prefixText,
      String? hintText,
      String? helperText,
      String? errorText,
      InputBorder? border,
      EdgeInsets? contentPadding,
      Color? fillColor,
      Widget? prefix,
      Widget? prefixIcon,
      FloatingLabelBehavior? floatingLabelBehavior,
      Widget? label}) {
    final isFilled = fillColor != null;
    return InputDecoration(
        fillColor: fillColor,
        filled: isFilled,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        floatingLabelBehavior: floatingLabelBehavior,
        prefixIconConstraints:
            const BoxConstraints(maxWidth: 48, maxHeight: 48),
        hintText: hintText,
        hintStyle:
            xStyle.bodyLarge?.copyWith(color: xColor.outline.withOpacity(0.4)),
        prefixText: prefixText,
        prefixStyle: xGreyStyleLarge,
        labelStyle: xGreyStyleLarge,
        contentPadding: contentPadding,
        helperText: helperText,
        errorText: errorText,
        border: isFilled
            ? OutlineInputBorder(
                borderRadius: radiusMedium, borderSide: BorderSide.none)
            : border ?? OutlineInputBorder(borderRadius: radiusSmall),
        isDense: true,
        label: label,
        labelText: labelText);
  }
}

class InputDropDown extends StatelessWidget {
  const InputDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return const Icon(Icons.arrow_drop_down, size: 26);
  }
}
