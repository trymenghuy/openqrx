import 'package:flutter/material.dart';
import 'package:openqrx/app/factory/theme/font_factory.dart';
import 'package:openqrx/app/provider/setting_provider.dart';
import 'package:openqrx/app/util/navigator.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/enum/size_font.dart';
import 'package:openqrx/helper/form/title_helper.dart';
import 'package:provider/provider.dart';

class SwitchFont extends StatelessWidget {
  const SwitchFont({super.key});
  static void pop(SettingProvider provider) {
    button.pop(
      child: AlertDialog(
        contentPadding: const EdgeInsets.symmetric(vertical: x20),
        title: const Text('Font size'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: SizeFont.values.map((e) {
            final isSelect = e == provider.font;
            final textTheme = AppFont(e).generate();
            // final textTheme = Typography.material2021()
            //     .black
            //     .apply(fontSizeFactor: e.value, fontSizeDelta: 1);
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: x20),
              onTap: isSelect
                  ? null
                  : () {
                      XNavigator.pop();
                      provider.setFont(e);
                    },
              subtitle: Text('This is a normal text',
                  style: textTheme.bodyLarge?.copyWith(color: xColor.outline)),
              dense: true,
              title: Text(
                  '${TitleHelper.camelToTitle(e.name)} ${e.value} (${textTheme.bodyLarge?.fontSize?.toInt()} px)',
                  style: xStyle.bodyLarge),
              leading: Icon(isSelect
                  ? Icons.radio_button_checked
                  : Icons.radio_button_unchecked),
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
          icon: const Icon(Icons.font_download),
        );
      },
    );
  }
}
