import 'package:flutter/material.dart';
import 'package:openqrx/app/factory/theme/color_factory.dart';
import 'package:openqrx/app/provider/setting_provider.dart';
import 'package:openqrx/app/util/navigator.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/enum/mode.dart';
import 'package:provider/provider.dart';

class SwitchMode extends StatelessWidget {
  const SwitchMode({super.key});
  static void pop(SettingProvider provider) {
    button.pop(
      child: AlertDialog(
        contentPadding: const EdgeInsets.symmetric(vertical: x20),
        title: const Text('Theme Mode'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: Mode.values.map((e) {
            BorderRadius borderRadius = BorderRadius.zero;
            if (e == Mode.values.last) {
              borderRadius =
                  const BorderRadius.vertical(bottom: Radius.circular(18));
            }
            final isSelect = e == provider.mode;
            final color = AppColor(e, XNavigator.context).generate();
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: x20),
              shape: RoundedRectangleBorder(borderRadius: borderRadius),
              leading: Icon(
                isSelect
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
              ),
              trailing: CircleAvatar(
                backgroundColor: color.surface,
                radius: 12,
                child: CircleAvatar(
                  backgroundColor: color.primary,
                  radius: 9,
                  child: CircleAvatar(
                    backgroundColor: color.secondary,
                    radius: 6,
                    child: CircleAvatar(
                      backgroundColor: color.onSurface,
                      radius: 3,
                    ),
                  ),
                ),
              ),
              onTap: isSelect
                  ? null
                  : () {
                      XNavigator.pop();
                      provider.setMode(e);
                    },
              title: Text(
                txt.mode(e.value),
                style: xStyle.bodyLarge,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, provider, _) {
        return IconButton(
          onPressed: () {
            pop(provider);
          },
          icon: const Icon(Icons.dark_mode_rounded),
        );
      },
    );
  }
}
