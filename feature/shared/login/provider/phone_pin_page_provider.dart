import 'package:flutter/material.dart';
import 'package:openqrx/app/util/app_state.dart';
import 'package:openqrx/app/util/print.dart';
import 'package:openqrx/feature/shared/login/provider/auth_services.dart';
import 'package:openqrx/feature/shared/widgets/app_state/loading_app_state.dart';

class PhonePinPageProvider with ChangeNotifier {
  String _code = '';
  void onCodeChange(String value) {
    _code = value;
  }

  AppState _widget = const AppState(noLoad: true);
  AppState get widget => _widget;
  void _setState(AppState state) {
    _widget = state;
    notifyListeners();
  }

  void submit() async {
    _setState(_widget.alert(const LoadingAppState()));
    xPrint("sendFirebaseOTP $_code");
    AuthServices.instance.onError = () => _setState(_widget.init());
    AuthServices.instance.verifyCode(_code);
  }
}
