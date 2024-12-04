import 'dart:convert';

import 'package:openqrx/app/constants/setting.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'preference.dart';

class XPreferenceImpl implements XPreference {
  final SharedPreferences sharedPreferences;
  XPreferenceImpl(this.sharedPreferences);

  @override
  String? getMode() => sharedPreferences.getString(Setting.DARK);
  @override
  void setMode(String value) =>
      sharedPreferences.setString(Setting.DARK, value);
  @override
  String? getLn() => sharedPreferences.getString(Setting.LANGUAGE);
  @override
  String? getRole() => sharedPreferences.getString('role');
  @override
  void setLn(String value) =>
      sharedPreferences.setString(Setting.LANGUAGE, value);
  @override
  String? getFont() => sharedPreferences.getString('fontSize');
  @override
  void setFont(String value) => sharedPreferences.setString('fontSize', value);
  @override
  Future<void> setRole(String? value) async {
    await sharedPreferences.setString('role', value.orEmpty);
  }

  @override
  Future<void> logout() async {
    // await sharedPreferences.remove(QAuth.TOKEN);
    // await sharedPreferences.remove(QAuth.REFRESH_TOKEN);
    // await sharedPreferences.remove(QAuth.PROFILE);
  }

  @override
  String? getToken() => sharedPreferences.getString('accessToken');

  @override
  Map<String, dynamic>? getFarm() {
    final data = sharedPreferences.getString('farm');
    if (data == null) return null;
    return jsonDecode(data) as Map<String, dynamic>;
  }

  @override
  Future<void> setFarm(Map<String, dynamic> value) async {
    await sharedPreferences.setString('farm', jsonEncode(value));
  }

  @override
  String? getDefaultFarm() => sharedPreferences.getString('defaultFarm');

  @override
  Future<void> setDefaultFarm(String value) async {
    await sharedPreferences.setString('defaultFarm', value);
  }

  @override
  List<ItemBase> getItemBase(String key) {
    final data = sharedPreferences.getString(key);
    if (data == null) {
      return [];
    }
    return (jsonDecode(data) as List)
        .map((e) => ItemBase.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  @override
  void setItemBase(String key, Iterable<ItemBase> value) async {
    await sharedPreferences.setString(
        key, jsonEncode(value.map((e) => e.toJson()).toList()));
  }
}
