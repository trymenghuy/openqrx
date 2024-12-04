import 'package:flutter/material.dart';
import 'package:openqrx/app/util/print.dart';

extension NavigatorStateExtension on NavigatorState {
  void pushNamedIfNotCurrent(String routeName, {dynamic arguments}) {
    if (!isCurrent(routeName)) {
      pushNamed(routeName, arguments: arguments);
    }
  }

  bool isCurrent(String routeName) {
    bool isCurrent = false;
    popUntil((route) {
      xPrint(route.settings.name);
      xPrint(routeName);
      if (route.settings.name == routeName) {
        isCurrent = true;
      }
      return true;
    });
    return isCurrent;
  }
}
