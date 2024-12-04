import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/util/di.dart';
import 'package:openqrx/app/util/navigator.dart';
import 'package:openqrx/app/util/print.dart';
import 'package:openqrx/app/util/route.dart';
import 'package:openqrx/domain/enum/e_role.dart';
import 'package:openqrx/domain/repository/preference.dart';

class UserProvider extends ChangeNotifier {
  static UserProvider? _instance;
  UserProvider._();
  static UserProvider get instance {
    _instance ??= UserProvider._();
    return _instance!;
  }

  final XPreference preference = getIt<XPreference>();

  bool get isLogged => user != null;
  ERole get role => ERole.fromString(preference.getRole());
  Map<String, dynamic> get farm => (preference.getFarm()).orEmpty;
  String? get defaultFarm =>
      farm.isNotEmpty ? preference.getDefaultFarm() ?? farm.keys.first : null;
  User? get user => FirebaseAuth.instance.currentUser;
  String? get uid => user?.uid;
  String? get phone => user?.phoneNumber;
  bool isMine(String uid) => user?.uid == uid;
  void logout() async {
    FirebaseAuth.instance.signOut();
    preference.setRole(null);
    preference.setFarm({});
    Navigator.of(XNavigator.context).pushNamedAndRemoveUntil(
        AppRoutes.login, (Route<dynamic> route) => false);
  }

  Future<void> getRole({bool forceRefresh = false}) async {
    if (isLogged) {
      IdTokenResult tokenResult = await user!.getIdTokenResult(forceRefresh);
      Map<String, dynamic>? claims = tokenResult.claims;
      xPrint(claims, error: true);
      preference.setRole(claims['role']);
      final farm = claims['farm'];
      if (farm != null) {
        preference.setFarm(Map<String, dynamic>.from(farm));
      }
    }
  }

  void notify() {
    notifyListeners();
  }
}
