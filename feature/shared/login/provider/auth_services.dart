import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:openqrx/app/provider/user_provider.dart';
import 'package:openqrx/app/util/di.dart';
import 'package:openqrx/app/util/navigator.dart';
import 'package:openqrx/app/util/print.dart';
import 'package:openqrx/app/util/route.dart';
import 'package:openqrx/domain/repository/preference.dart';
import 'package:openqrx/helper/service/error_service.dart';

class AuthServices {
  static AuthServices? _instance;
  AuthServices._();
  static AuthServices get instance {
    _instance ??= AuthServices._();
    return _instance!;
  }

  final XPreference preference = getIt<XPreference>();
  VoidCallback? onError;
  int? forceResendingToken;
  String? verificationId;
  String? phone;
  void sendCode(String phone) async {
    this.phone = phone;
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      forceResendingToken: forceResendingToken,
      verificationCompleted: (PhoneAuthCredential credential) {
        onVerify(credential);
      },
      timeout: const Duration(seconds: 120),
      verificationFailed: (FirebaseAuthException e) {
        onError?.call();
        ErrorService.pop(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        xPrint("verificationId $verificationId");
        forceResendingToken = resendToken;
        this.verificationId = verificationId;
        XNavigator.pushReplacementNamed(AppRoutes.verifyCode);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyCode(String code) async {
    if (verificationId == null) return;
    final credential = PhoneAuthProvider.credential(
        verificationId: verificationId!, smsCode: code);
    onVerify(credential);
  }

  void onVerify(PhoneAuthCredential credential) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) throw ('User not found');
      await UserProvider.instance.getRole();
      if (user.displayName == null) {
        XNavigator.pushReplacementNamed(AppRoutes.profileSetup);
      } else {
        XNavigator.pushReplacementNamed(AppRoutes.home);
      }
    } catch (e) {
      onError?.call();
      ErrorService.pop(e.toString());
    }
  }
}
