import 'package:flutter/material.dart';
import 'package:openqrx/app/util/app_provider.dart';
import 'package:openqrx/feature/shared/usage/provider/usage_page_provider.dart';
import 'package:provider/provider.dart';

class UsagePage extends StatelessWidget {
  const UsagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      provider: UsagePageProvider(),
      onReady: (p) {},
      child: Consumer<UsagePageProvider>(builder: (_, provider, __) {
        return provider.widget.build(builder: (data) {
          return const Scaffold();
        });
      }),
    );
  }
}
