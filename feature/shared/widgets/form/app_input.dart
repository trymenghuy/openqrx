import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/util/print.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/feature/shared/widgets/form/input_style.dart';
import 'package:openqrx/helper/form/validate_helper.dart';

// bool forceValidate = false;

class AppInput extends StatefulWidget {
  const AppInput({
    super.key,
    this.value,
    this.keyboardType = TextInputType.text,
    this.obsecure = false,
    this.onTap,
    this.readOnly = false,
    this.autofocus = false,
    this.label,
    this.labelText,
    this.suffixIcon,
    this.textAlign,
    this.style,
    this.prefixIcon,
    this.enabled = true,
    this.textCapitalization = TextCapitalization.words,
    this.onEditingCompleted,
    this.onFieldSubmitted,
    this.inputFormatters,
    this.validatorKey,
    this.validator,
    this.onChanged,
    this.decoration,
    this.minLines,
    this.maxLines,
    this.focusNode,
    this.textInputAction,
  });
  final String? value;
  final bool obsecure;
  final bool readOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEditingCompleted;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final bool autofocus;
  final bool enabled;
  final TextStyle? style;
  final String? validatorKey;
  final String? labelText;
  final Widget? label;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextAlign? textAlign;
  final InputDecoration? decoration;
  final int? minLines;
  final String? Function(String?)? validator;
  final int? maxLines;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;

  @override
  State<AppInput> createState() => AppInputState();
}

class AppInputState extends State<AppInput> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _controller = TextEditingController.fromValue(
        TextEditingValue(text: widget.value ?? ''));
    super.initState();
  }

  void clear() {
    _controller.clear();
  }

  void reset(String e) {
    _controller.text = e;
    _controller.selection = TextSelection.collapsed(offset: e.length);
    widget.onChanged?.call(e);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String get text => _controller.text;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      controller: widget.onTap == null && widget.enabled
          ? _controller
          : TextEditingController(text: widget.value),
      onChanged: (v) {
        widget.onChanged?.call(v);
      },
      textAlign: widget.textAlign ?? TextAlign.left,
      onEditingComplete: widget.onEditingCompleted,
      textCapitalization: widget.textCapitalization,
      autofocus: widget.autofocus,
      focusNode: _focusNode,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      style: xStyle.bodyLarge,
      // style: widget.style,
      onTap: widget.onTap,
      enabled: widget.enabled,
      inputFormatters: widget.inputFormatters,
      readOnly: widget.readOnly,
      validator: (v) {
        String? error;
        if ((widget.validatorKey != null || widget.validator != null) &&
            (_focusNode.hasFocus ||
                v.orEmpty.isNotEmpty ||
                ValidateHelper.forceValidate)) {
          xPrint(widget.validatorKey);
          error ??= ValidateHelper.check(widget.validatorKey!)?.call(v);
          error ??= widget.validator?.call(v);
          xPrint('${widget.validatorKey} ---- $v ----- $error');
        }
        return error;
      },
      obscureText: widget.obsecure,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: widget.decoration ??
          InputStyle.border(
              labelText: widget.labelText,
              label: widget.label,
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon),
    );
  }
}
