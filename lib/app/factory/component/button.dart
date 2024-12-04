import 'package:flutter/material.dart';
import 'package:openqrx/app/factory/component/os/android_button.dart';
import 'package:openqrx/app/factory/component/os/ios_button.dart';

abstract class ButtonFactory {
  Button createButton();
}

abstract class Button {
  Widget loading({bool light = false});
  Widget get smallLoad;
  Widget dialog(
      {required String title,
      required List<Widget> children,
      List<Widget>? actions});
  Widget textButton(
      {required String text, required VoidCallback? onTap, bool? danger});
  Widget actionButton(
      {required String text, required VoidCallback onTap, bool? danger});
  void popDialog(
      {required String title,
      required List<Widget> children,
      List<Widget>? actions});
  void pop({required Widget child});
  void confirm({
    required String title,
    required String subTitle,
    String? next,
    required VoidCallback onNext,
  });
}

class IOSButtonFactory implements ButtonFactory {
  @override
  Button createButton() {
    return IOSButton();
  }
}

class AndroidButtonFactory implements ButtonFactory {
  @override
  Button createButton() {
    return AndroidButton();
  }
}
