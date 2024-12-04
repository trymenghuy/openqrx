// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';

class ValidateHelper {
  // static ValidateHelper? _instance;
  // ValidateHelper._();
  // static ValidateHelper get instance {
  //   _instance ??= ValidateHelper._();
  //   return _instance!;
  // }

  static bool forceValidate = false;
  static void submit(
      {required GlobalKey<FormState> formKey, required VoidCallback onNext}) {
    forceValidate = true;
    final valid = formKey.currentState?.validate();
    forceValidate = false;
    if (valid == true) onNext();
  }

  static String? Function(String?)? check(String key) {
    String? validate(String? value) {
      if (value == null || value.isEmpty) {
        return '$key cannot be empty';
      }
      switch (key) {
        case 'firstName':
        case 'secondName':
          if (value.length < 2 || value.length > 20) {
            return '$key must be between 2 and 20 characters';
          }
          break;
        case 'penName':
          if (value.length < 2 || value.length > 10) {
            return '$key must be between 2 and 20 characters';
          }
          break;
        case 'feed':
        case 'net':
        case 'age':
        case 'dead':
        case 'weight':
          if (int.tryParse(value).orZero == 0) {
            return '$key larger than 0';
          }
          break;
        case 'username':
          if (value.length < 5 || value.length > 20) {
            return '$key must be between 5 and 20 characters';
          }
          if (!RegExp(r'^[a-zA-Z][a-zA-Z0-9_]*$').hasMatch(value)) {
            return 'Invalid $key format';
          }
          break;
        case 'password':
        case 'confirmPassword':
          if (value.length < 6) {
            return '$key must be at least 6 characters';
          }
          break;
        case 'email':
          if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
              .hasMatch(value)) {
            return 'Invalid $key format';
          }
          break;
      }
      return null;
    }

    return validate;
  }
}
