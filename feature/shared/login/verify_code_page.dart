import 'package:flutter/material.dart';
import 'package:openqrx/app/util/app_provider.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/feature/shared/login/provider/verify_code_page_provider.dart';
import 'package:openqrx/feature/shared/widgets/buttons/long_button.dart';
import 'package:openqrx/feature/shared/widgets/form/app_input.dart';
import 'package:provider/provider.dart';

class VerifyCodePage extends StatelessWidget {
  final String? phone;
  const VerifyCodePage({super.key, this.phone});

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      provider: VerifyCodePageProvider(),
      onReady: (p) {
        p.init(phone);
      },
      child: Consumer<VerifyCodePageProvider>(builder: (_, provider, __) {
        return Scaffold(
          body: provider.widget.build(builder: (data) {
            return Center(
              child: ListView(
                padding: const EdgeInsets.all(x30),
                shrinkWrap: true,
                children: [
                  Text(
                    txt.verification,
                    style: xStyle.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  space30,
                  AppInput(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      provider.onCodeChange(value);
                    },
                  ),
                  space20,
                  LongButton(
                    onTap: data.verificationId == null
                        ? null
                        : () {
                            FocusScope.of(context).unfocus();
                            provider.submit();
                          },
                  ),
                  space20,
                ],
              ),
            );
          }),
        );
      }),
    );
  }
}
