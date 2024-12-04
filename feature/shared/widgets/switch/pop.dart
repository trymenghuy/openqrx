import 'package:flutter/material.dart';
import 'package:openqrx/app/util/navigator.dart';

class XPop {
  static void bottomSheet({required Widget child}) {
    showModalBottomSheet(
      context: XNavigator.context,
      isScrollControlled: true,
      builder: (_) => child,
    );
  }
}
