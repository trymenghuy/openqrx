import 'package:flutter/material.dart';
import 'package:openqrx/app/util/app_state.dart';
import 'package:openqrx/app/util/print.dart';
import 'package:openqrx/feature/shared/login/provider/auth_services.dart';
import 'package:openqrx/feature/shared/widgets/app_state/loading_app_state.dart';
import 'package:openqrx/helper/form/format_helper.dart';

class LoginPageProvider with ChangeNotifier {
  String _number = '';
  void onPhoneChange(String value) {
    _number = value;
  }

  AppState _widget = const AppState(noLoad: true);
  AppState get widget => _widget;
  void _setState(AppState state) {
    _widget = state;
    notifyListeners();
  }

  void login() async {
    _setState(_widget.alert(const LoadingAppState()));
    AuthServices.instance.onError = () => _setState(_widget.set());
    final phone = FormatHelper.phone(_number);
    xPrint(phone);
    AuthServices.instance.sendCode(phone);
  }
}
