import 'package:flutter/material.dart';
import 'package:openqrx/app/util/navigator.dart';
import 'package:openqrx/app/util/txt.dart';

class ErrorService {
  static void pop(String? text, {String? title}) {
    button.popDialog(title: title ?? 'Error', children: [
      Text(text ?? txt.error_occurred)
    ], actions: [
      button.actionButton(
          text: 'Close',
          onTap: () {
            XNavigator.pop();
          })
    ]);
  }
}
