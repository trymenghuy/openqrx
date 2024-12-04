import 'package:flutter/material.dart';
import 'package:openqrx/app/util/app_provider.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/feature/shared/login/provider/phone_pin_page_provider.dart';
import 'package:openqrx/feature/shared/widgets/buttons/long_button.dart';
import 'package:openqrx/feature/shared/widgets/form/app_input.dart';
import 'package:provider/provider.dart';

class PhonePinPage extends StatefulWidget {
  const PhonePinPage({super.key});

  @override
  State<PhonePinPage> createState() => _PhonePinPageState();
}

class _PhonePinPageState extends State<PhonePinPage> {
  @override
  Widget build(BuildContext context) {
    return AppProvider(
      provider: PhonePinPageProvider(),
      child: Consumer<PhonePinPageProvider>(builder: (_, provider, __) {
        return provider.widget.build(
            builder: (_) => Scaffold(
                  body: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(x30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            radius: x40,
                            child: Icon(Icons.password),
                          ),
                          space15,
                          Text(
                            txt.verify,
                            style: xStyle.headlineMedium,
                          ),
                          space20,
                          AppInput(
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              provider.onCodeChange(value);
                            },
                          ),
                          space20,
                          LongButton(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              provider.submit();
                            },
                          ),
                          space20,
                        ],
                      ),
                    ),
                  ),
                ));
      }),
    );
  }
}
