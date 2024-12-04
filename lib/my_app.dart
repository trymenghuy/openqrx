import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:openqrx/app/factory/theme/color_factory.dart';
import 'package:openqrx/app/provider/setting_provider.dart';
import 'package:openqrx/app/util/navigator.dart';
import 'package:openqrx/app/util/route.dart';
import 'package:openqrx/app/util/theme.dart';
import 'package:openqrx/domain/enum/mode.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (_, setting, __) {
        Intl.defaultLocale = setting.ln.value;
        // final color = ColorScheme.fromSeed(seedColor: Colors.purple);
        // double defaultTextScaleFactor =
        //     MediaQuery.textScalerOf(context).textScaleFactor;
        // xPrint(defaultTextScaleFactor);
        final color = AppColor(setting.mode, context).generate();
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: (setting.mode == Mode.dark
                  ? SystemUiOverlayStyle.light
                  : SystemUiOverlayStyle.dark)
              .copyWith(systemNavigationBarColor: color.surface),
          child: MaterialApp(
            navigatorKey: XNavigator.navigatorKey,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(setting.ln.value),
            debugShowCheckedModeBanner: false,
            theme: buildTheme(color, setting.font, setting.ln),
            onGenerateRoute: RouteGenerator.getRoute,
            // home: const P1(),
          ),
        );
      },
    );
  }
}
