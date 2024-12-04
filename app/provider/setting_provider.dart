import 'package:flutter/material.dart';
import 'package:openqrx/app/util/di.dart';
import 'package:openqrx/app/util/print.dart';
import 'package:openqrx/domain/enum/ln.dart';
import 'package:openqrx/domain/enum/mode.dart';
import 'package:openqrx/domain/enum/size_font.dart';
import 'package:openqrx/domain/repository/preference.dart';

class SettingProvider extends ChangeNotifier {
  static SettingProvider? _instance;
  SettingProvider._();
  static SettingProvider get instance {
    _instance ??= SettingProvider._();
    return _instance!;
  }

  final XPreference preference = getIt<XPreference>();
  Mode get mode => Mode.fromString(preference.getMode());
  LN get ln => LN.fromString(preference.getLn());
  bool get isKh => ln == LN.km;
  SizeFont get font => SizeFont.fromString(preference.getFont());
  void setMode(Mode e) {
    preference.setMode(e.value);
    notifyListeners();
  }

  void setFont(SizeFont e) {
    preference.setFont(e.name);
    notifyListeners();
  }

  void setLn(LN e) {
    preference.setLn(e.value);
    xPrint("setLn$e");
    notifyListeners();
  }
}
