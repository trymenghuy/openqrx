import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:openqrx/app/factory/component/button.dart';
import 'package:openqrx/app/provider/setting_provider.dart';
import 'package:openqrx/app/provider/storage_provider.dart';
import 'package:openqrx/app/provider/user_provider.dart';
import 'package:openqrx/app/util/di.dart';
import 'package:openqrx/my_app.dart';
import 'package:provider/provider.dart';

import 'app/util/txt.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initAppModule();
  button = (Platform.isAndroid ? AndroidButtonFactory() : IOSButtonFactory())
      .createButton();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UserProvider.instance),
      ChangeNotifierProvider(create: (_) => StorageProvider.instance),
      ChangeNotifierProvider(create: (_) => SettingProvider.instance),
    ], child: const MyApp());
  }
}
