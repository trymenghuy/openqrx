import 'package:flutter/material.dart';

enum Mode {
  system('system'),
  light('light'),
  dark('dark'),
  pink('pink'),
  green('green');

  const Mode(this.value);
  final String value;
  IconData get getIcon =>
      this == Mode.light ? Icons.light_mode_outlined : Icons.dark_mode_outlined;
  factory Mode.fromString(String? ln) {
    return Mode.values
        .firstWhere((e) => e.value == ln, orElse: () => Mode.system);
  }
}
