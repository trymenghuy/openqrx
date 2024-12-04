import 'package:openqrx/domain/enum/item_base.dart';

abstract class XPreference {
  String? getMode();
  void setMode(String value);
  List<ItemBase> getItemBase(String key);
  void setItemBase(String key, Iterable<ItemBase> value);
  String? getLn();
  String? getRole();
  String? getToken();
  Map<String, dynamic>? getFarm();
  String? getDefaultFarm();
  void setLn(String value);
  void setRole(String? value);
  Future<void> setFarm(Map<String, dynamic> value);
  Future<void> setDefaultFarm(String value);
  String? getFont();
  void setFont(String value);
  Future<void> logout();
}
