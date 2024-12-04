// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:openqrx/app/util/navigator.dart';
import 'package:openqrx/app/util/txt.dart';

class Toast {
  static void pop(String text, {bool error = false}) {
    ScaffoldMessenger.of(XNavigator.context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 3),
          padding: const EdgeInsets.symmetric(horizontal: x20, vertical: x15),
          backgroundColor: error ? xColor.error : xColor.primary,
          content: Text(
            text,
            style: xStyle.bodyLarge
                ?.copyWith(color: error ? xColor.onError : xColor.onPrimary),
          ),
        ),
      );
  }
}
