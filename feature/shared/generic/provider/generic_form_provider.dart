import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/provider/storage_provider.dart';
import 'package:openqrx/app/provider/user_provider.dart';
import 'package:openqrx/app/util/app_state.dart';
import 'package:openqrx/app/util/di.dart';
import 'package:openqrx/app/util/print.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/model/buy/nested_item.dart';
import 'package:openqrx/domain/model/input_rule.dart';
import 'package:openqrx/domain/repository/preference.dart';
import 'package:openqrx/feature/shared/generic/abstract/generic_form_abstract.dart';
import 'package:openqrx/feature/shared/widgets/app_state/loading_app_state.dart';
import 'package:openqrx/helper/form/convert_helper.dart';
import 'package:openqrx/helper/form/title_helper.dart';
import 'package:openqrx/helper/service/store_service.dart';
import 'package:openqrx/helper/toast_helper.dart';

class GenericFormProvider with ChangeNotifier implements GenericFormAbstract {
  AppState<InputRule> _widget = const AppState();
  AppState<InputRule> get widget => _widget;
  final Function(Map<String, dynamic> map)? onSubmit;
  final bool farmLevel;
  final Map<String, dynamic>? translate;
  GenericFormProvider(this.farmLevel, this.onSubmit, this.translate);
  late InputRule input;
  Map<String, String> error = {};
  final XPreference preference = getIt<XPreference>();
  void _setState(AppState<InputRule> state) {
    _widget = state;
    notifyListeners();
  }

  String tran(String text) {
    return translate?[text] ?? TitleHelper.camelToTitle(text);
  }

  Map<String, Map<String, NestedItem>> nestedInput = {};
  @override
  void removeNestedQtyInput(String key, String id) {
    nestedInput[key]?.remove(id);
    input.map[key].remove(id);
    notifyListeners();
  }

  @override
  void onSumQtyChanged(String key, String id, int value) {
    int q = (nestedInput[key]?[id]?.quantity).orZero;
    q = q + value;
    if (q > 0) {
      nestedInput[key]?[id]?.quantity = q;
      notifyListeners();
    } else {
      button.confirm(
          title: 'Remove Product',
          subTitle: 'Are you sure you want to remove this product?',
          onNext: () {
            removeNestedQtyInput(key, id);
          });
    }
  }

  @override
  void onQtyChanged(String key, String id, int value) {
    nestedInput[key]?[id]?.quantity = value;
    notifyListeners();
  }

  @override
  void onNestInputChanged(String key, String id, dynamic value,
      {bool notify = false}) {
    nestedInput[key]?[id]?.value = value;
    if (notify) {
      notifyListeners();
    }
  }

  @override
  void onChanged(String key, dynamic value) {
    if (input.isFile(key)) {
      input.map['${key}Path'] = value;
      notifyListeners();
      return;
    } else {
      input.map[key] = value;
    }
    final isDigits = input.isDigit(key);
    xPrint('$key $value');
    if (input.isOpt(key)) {
      if (input.isNestOption(key)) {
        if (value != null) {
          final productIds = isDigits
              ? List.generate(value, (i) => '${i + 1}')
              : List.from(value);
          nestedInput.putIfAbsent(key, () => {});
          value = input.map[key] ?? 0;
          for (final e in productIds) {
            if (!nestedInput[key]!.containsKey(e)) {
              final item = input.getOptMap[key]?.getFirstWhere(
                  (f) => f.value == (isDigits ? int.parse(e) : e));
              if (item != null) {
                nestedInput[key]![e] =
                    input.nestedOptMapper?[key]?.call(item).zeroValue ??
                        NestedItem(
                          title: item.title,
                          value: item.worth.orZero,
                          unit: item.unit,
                          quantity: input.id == 'buy' ? 1 : 0,
                        );
              }
            }
          }
          nestedInput[key]?.removeWhere((k, v) => !productIds.contains(k));
        } else {
          nestedInput.remove(key);
        }
      } else if (['uid'].contains(key)) {
        final profile =
            input.getOptMap[key]?.getFirstWhere((f) => f.value == value);
        if (profile != null) {
          input.map.putIfAbsent('other', () => {});
          input.map['other']!['uid'] = profile.toJson().nullClean;
        }
      }
      notifyListeners();
    } else if (input.isDecimal(key)) {
      input.map[key] = double.tryParse(value);
    } else if (input.isDigit(key)) {
      input.map[key] = int.tryParse(value);
    }
  }

  void get(InputRule input, Map<String, dynamic>? initMap) async {
    final map = Map<String, dynamic>.from(initMap ?? {});
    final other = Map<dynamic, dynamic>.from(map['other'] ?? {});
    final hasDynamicOption = input.dynamicOption.orIsNotEmpty;
    xPrint(map);
    xPrint(other);
    if (other['nestedInput'] != null) {
      nestedInput = other['nestedInput'];
    }
    this.input = input.copy;
    if (hasDynamicOption) {
      for (var e in input.dynamicOption!.keys) {
        final cached = preference.getItemBase('$e-${input.id}');
        this.input.option![e] = cached;
      }
    }
    for (var e in map.entries) {
      if (this.input.map.containsKey(e.key)) {
        this.input.map[e.key] = e.value;
      }
    }
    _setState(_widget.set(this.input));
    if (hasDynamicOption) {
      for (var e in input.dynamicOption!.entries) {
        final items = await e.value();
        this.input.option![e.key] = items;
        preference.setItemBase('$e-${input.id}', items);
      }
      _setState(_widget.set(this.input));
    }
    xPrint(this.input.getOptMap, error: true);
  }

  Future<Map<String, dynamic>?> submit() async {
    error.clear();
    for (var e in input.validKeys) {
      if (input.optionals?.contains(e) != true &&
          ConvertHelper.otherToString(input.map[e]).isEmpty) {
        error[e] = '${tran(e)} is required';
      }
    }
    final map = Map<String, dynamic>.from(input.map);
    if (nestedInput.isNotEmpty) {
      for (var e in nestedInput.entries) {
        if (e.value.entries.any((f) => f.value.isNotValid)) {
          error[e.key] = '${tran(e.key)} is required';
        }
        map[e.key] = Map<String, dynamic>.from(
          e.value.map((key, value) => MapEntry(key, value.toJson().nullClean)),
        );
      }
    }
    xPrint(map);
    if (error.isNotEmpty) {
      xPrint(error, error: true);
      notifyListeners();
      return null;
    }
    // return null;
    _setState(_widget.alert(const LoadingAppState()));
    final id = map['id'];

    try {
      String message;
      final collection =
          input.id[0].toUpperCase() + input.id.substring(1).toLowerCase();
      final collectionName = farmLevel
          ? 'Farm/${UserProvider.instance.defaultFarm}/$collection'
          : collection;
      for (final e in map.entries) {
        if (e.key.isPath) {
          final thumbSize = input.thumbSize?[e.key];
          final url = await StorageProvider.instance
              .uploadFile(e.value, collectionName, thumbSize: thumbSize);
          final urlKey = e.key.replaceAll("Path", "");
          if (map[urlKey] != null) {
            await StorageProvider.instance.delete(map[urlKey]);
          }
          map[urlKey] = url;
        }
      }
      xPrint(map);
      if (onSubmit == null) {
        if (id != null) {
          message = '$collection updated successfully';
          await StoreService.instance
              .collection(collectionName)
              .doc(id)
              .update(map.clean(addUpdatedAt: true));
          map['updatedAt'] = DateTime.now();
        } else {
          message = '$collection created successfully';
          final doc = await StoreService.instance
              .collection(collectionName)
              .add(map.clean());
          map['id'] = doc.id;
          map['createdBy'] = UserProvider.instance.uid;
          map['createdAt'] = DateTime.now();
        }
        Toast.pop(message);
      } else {
        onSubmit!(map);
      }
      return map;
    } catch (e) {
      Toast.pop(e.toString(), error: true);
      return null;
    }
  }
}
