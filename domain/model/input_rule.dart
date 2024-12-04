// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:openqrx/domain/model/buy/nested_item.dart';
import 'package:openqrx/feature/shared/generic/abstract/generic_form_abstract.dart';

typedef OperatorBuilder = Widget Function(MapEntry<String, NestedItem>,
    GenericFormAbstract, MapEntry<String, dynamic>);
typedef NestedItemBuilder = NestedItem Function(ItemBase e);

class InputRule {
  final String id;
  Map<String, dynamic> map;
  final String? description;
  final List<String>? skips;
  final List<String>? digits;
  final List<String>? dates;
  final List<String>? decimals;
  final List<String>? files;
  final List<String>? optionals;
  final List<String>? multiline;
  final List<String>? multiOptions;
  final List<String>? optionAsBottom;
  final List<String>? optionAsDialog;
  final Map<String, String>? afterText;
  final Map<String, String>? icons;
  final Map<String, int>? thumbSize;

  final Map<String, NestedItemBuilder>? nestedOptMapper;
  Map<String, Iterable<ItemBase>>? option;
  Map<String, OperatorBuilder>? nestedOptions;
  final Map<String, Future<Iterable<ItemBase>> Function()>? dynamicOption;

  Iterable<String> get getOptKeys =>
      [...?option?.keys, ...?nestedOptions?.keys, ...?dates];
  Map<String, Iterable<ItemBase>> get getOptMap => {...?option};
  Iterable<String> get getSkips =>
      ['id', 'other', ...?skips, ...map.keys.where((e) => e.isPath)];
  Iterable<String> get validKeys =>
      map.keys.where((e) => !getSkips.contains(e));

  InputRule(
      {required this.id,
      required this.map,
      this.description,
      this.afterText,
      this.dates,
      this.optionals,
      this.files,
      this.multiline,
      this.multiOptions,
      this.optionAsBottom,
      this.optionAsDialog,
      this.nestedOptMapper,
      this.icons,
      this.skips,
      this.digits,
      this.decimals,
      this.option,
      this.dynamicOption,
      this.nestedOptions,
      this.thumbSize});
  bool isMultiOptions(String key) => multiOptions?.contains(key) == true;
  bool isMultiLines(String key) => multiline?.contains(key) == true;
  bool isOpt(String key) => getOptKeys.contains(key);
  bool isOption(String key) => option?.containsKey(key) == true;
  bool isNestedOptMapper(String key) =>
      nestedOptMapper?.containsKey(key) == true;
  bool isDigit(String key) => digits?.contains(key) == true;
  bool isNestOption(String key) => nestedOptions?.containsKey(key) == true;
  bool isFile(String key) => files?.contains(key) == true;
  bool isDecimal(String key) => decimals?.contains(key) == true;
  bool isDate(String key) => dates?.contains(key) == true;
  bool isOptionAsDialog(String key) => optionAsDialog?.contains(key) == true;
  bool isOptionAsBottomSheet(String key) =>
      optionAsBottom?.contains(key) == true;
  InputRule get copy => InputRule(
        id: id,
        description: description,
        skips: List.from(skips.orEmpty),
        digits: List.from(digits.orEmpty),
        dates: List.from(dates.orEmpty),
        files: List.from(files.orEmpty),
        optionals: List.from(optionals.orEmpty),
        multiline: List.from(multiline.orEmpty),
        multiOptions: List.from(multiOptions.orEmpty),
        optionAsBottom: List.from(optionAsBottom.orEmpty),
        optionAsDialog: List.from(optionAsDialog.orEmpty),
        nestedOptMapper: Map.from(nestedOptMapper.orEmpty),
        nestedOptions: Map.from(nestedOptions.orEmpty),
        icons: Map.from(icons.orEmpty),
        map: Map.from(map),
        option: Map.from(option.orEmpty),
        dynamicOption: Map.from(dynamicOption.orEmpty),
        thumbSize: Map.from(thumbSize.orEmpty),
      );
}
