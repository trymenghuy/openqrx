import 'package:flutter/material.dart';
import 'package:openqrx/app/util/app_state.dart';

class UsagePageProvider with ChangeNotifier {
  AppState<dynamic> _widget = const AppState();
  AppState<dynamic> get widget => _widget;
  void _setState(AppState<dynamic> state) {
    _widget = state;
    notifyListeners();
  }

  void get() async {}
}
