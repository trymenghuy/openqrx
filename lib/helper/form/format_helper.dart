import 'package:flutter/services.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/helper/form/number_input_helper.dart';

class FormatHelper {
  static List<String> extractLinks(String? text) {
    if (text == null) return [];
    final matches = RegExp(r'https?://\S+').allMatches(text);
    return matches.map((match) => match.group(0)!).toList();
  }

  static String phone(String input) {
    input = input.replaceAll(' ', '');
    if (input.startsWith('+855')) {
      return input;
    } else if (input.startsWith('855')) {
      return '+$input';
    } else if (input.startsWith('0')) {
      return '+855${input.substring(1)}';
    } else {
      return '+855$input';
    }
  }

  static String formatNum(num? n) {
    if (n is int) return n.toString();
    if (n is num) return n.toDollar;
    return '';
  }

  static String toPhoneNumber(String phoneNumber) {
    phoneNumber = phoneNumber.replaceAll('+855', '0');
    return phoneNumber.replaceAllMapped(
        RegExp(r'(\d{3})(\d{3})(\d+)'), (Match m) => "${m[1]} ${m[2]} ${m[3]}");
  }

  static List<TextInputFormatter> doubleOnly = [
    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
  ];
  static List<TextInputFormatter> digitOnly = [
    FilteringTextInputFormatter.allow(RegExp(r"[\d]")),
    FilteringTextInputFormatter.deny(RegExp(r'^0+')),
    // LengthLimitingTextInputFormatter(4),
  ];
  static List<TextInputFormatter> phoneNumber = [
    FilteringTextInputFormatter.allow(RegExp(r"[\d.]")),
    LengthLimitingTextInputFormatter(9),
    InputNumberFormatter(),
  ];
}
