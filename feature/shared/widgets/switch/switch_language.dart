import 'package:flutter/material.dart';
import 'package:openqrx/app/provider/setting_provider.dart';
import 'package:openqrx/app/util/navigator.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/enum/ln.dart';
import 'package:openqrx/feature/shared/widgets/svg_icon.dart';
import 'package:provider/provider.dart';

class SwitchLanguage extends StatelessWidget {
  const SwitchLanguage({super.key});
  static void pop(SettingProvider provider) {
    button.pop(
      child: AlertDialog(
        contentPadding: const EdgeInsets.symmetric(vertical: x20),
        title: const Text('Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: LN.values.map((e) {
            final isSelect = e == provider.ln;
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: x20),
              leading: Icon(
                isSelect
                    ? Icons.radio_button_checked
                    : Icons.radio_button_unchecked,
              ),
              onTap: isSelect
                  ? null
                  : () {
                      XNavigator.pop();
                      provider.setLn(e);
                    },
              title: Text(e.title),
              trailing: SvgIcon(
                e.getSvg,
                noFilter: true,
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
          onPressed: () => pop(provider),
          icon: const Icon(Icons.translate_rounded),
        );
      },
    );
  }
}
