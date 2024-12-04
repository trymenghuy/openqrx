import 'package:flutter/material.dart';
import 'package:openqrx/app/util/app_provider.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/feature/shared/login/provider/login_page_provider.dart';
import 'package:openqrx/feature/shared/widgets/buttons/long_button.dart';
import 'package:openqrx/feature/shared/widgets/form/app_input.dart';
import 'package:openqrx/feature/shared/widgets/form/input_style.dart';
import 'package:openqrx/helper/form/format_helper.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      provider: LoginPageProvider(),
      onReady: (p) {},
      child: Consumer<LoginPageProvider>(builder: (_, provider, __) {
        return Scaffold(
          body: provider.widget.build(builder: (data) {
            return Center(
              child: ListView(
                padding: const EdgeInsets.all(x30),
                shrinkWrap: true,
                children: [
                  Text(
                    txt.loginTitle,
                    style: xStyle.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  space30,
                  AppInput(
                    keyboardType: TextInputType.phone,
                    inputFormatters: FormatHelper.phoneNumber,
                    onChanged: (value) {
                      provider.onPhoneChange(value);
                    },
                    decoration: InputStyle.border(
                      labelText: 'Phone number',
                      prefixText: '0',
                    ),
                  ),
                  space20,
                  LongButton(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      provider.login();
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
