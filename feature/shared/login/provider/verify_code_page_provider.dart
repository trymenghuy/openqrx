import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:openqrx/app/util/app_state.dart';
import 'package:openqrx/app/util/print.dart';
import 'package:openqrx/feature/shared/widgets/app_state/loading_app_state.dart';
import 'package:openqrx/helper/service/error_service.dart';
import 'package:openqrx/helper/service/store_service.dart';

class VerifyCodeData {
  String? phone;
  int? forceResendingToken;
  String? verificationId;
  String? code;
}

class VerifyCodePageProvider with ChangeNotifier {
  final VerifyCodeData _data = VerifyCodeData();
  AppState<VerifyCodeData> _widget = AppState(
      noLoad: true, float: const LoadingAppState(), data: VerifyCodeData());
  AppState<VerifyCodeData> get widget => _widget;
  void _setState(AppState<VerifyCodeData> state) {
    _widget = state;
    notifyListeners();
  }

  void init(String? phone) async {
    _data.phone = phone;
    sendCode();
  }

  void onCodeChange(String value) {
    _data.code = value;
  }

  void sendCode() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: _data.phone,
      forceResendingToken: _data.forceResendingToken,
      verificationCompleted: (PhoneAuthCredential credential) {
        _onVerify(credential);
      },
      timeout: const Duration(seconds: 120),
      verificationFailed: (FirebaseAuthException e) {
        ErrorService.pop(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        xPrint("verificationId $verificationId");
        _data.forceResendingToken = resendToken;
        _data.verificationId = verificationId;
        // XNavigator.pushReplacementNamed(Routes.phonePin);
        _setState(_widget.init(_data));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void submit() async {
    xPrint(_data.code);
    _setState(_widget.alert(const LoadingAppState()));
    if (_data.verificationId == null || _data.code == null) return;
    final credential = PhoneAuthProvider.credential(
        verificationId: _data.verificationId!, smsCode: _data.code!);
    _onVerify(credential);
  }

  void _onVerify(PhoneAuthCredential credential) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) throw ('User not found');
      final isNewUser = userCredential.additionalUserInfo?.isNewUser == true;
      if (isNewUser) {
        await StoreService.instance
            .doc('User', user.uid)
            .set({'phone': user.phoneNumber});
        // XNavigator.pushReplacementNamed(Routes.setProfile);
      } else {
        final doc = await StoreService.instance.doc('Role', user.uid).get();
        final data = doc.data()?['role'];
        xPrint(data);
      }
    } catch (e) {
      ErrorService.pop(e.toString());
      _setState(_widget.set());
    }
  }
}
