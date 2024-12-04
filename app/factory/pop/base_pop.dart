import 'package:flutter/material.dart';
import 'package:openqrx/app/factory/pop/bottom_pop.dart';
import 'package:openqrx/app/factory/pop/dialog_pop.dart';
import 'package:openqrx/app/factory/pop/menu_pop.dart';
import 'package:openqrx/app/service/date_service.dart';
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:openqrx/helper/form/convert_helper.dart';

abstract class BasePopup {
  // Future<dynamic> start({
  //   required String title,
  //   required BuildContext context,
  //   required Offset position,
  //   required Iterable<ItemBase> options,
  //   dynamic selected,
  // });

  Future<dynamic> pickOne({
    required String title,
    required BuildContext context,
    required Offset position,
    required Iterable<ItemBase> options,
    dynamic selected,
  });
  Future<dynamic> pickMulti({
    required String title,
    required BuildContext context,
    required Offset position,
    required Iterable<ItemBase> options,
    List<dynamic>? selected,
  });
}

class BaseDatePop {
  Future<dynamic> pickDate(dynamic value) async {
    return await DateService.instance
        .pickDate(now: ConvertHelper.otherToDate(value));
  }
}

enum PopupType { menu, dialog, bottomSheet }

// class PopupFactory {
//   static BasePopup create(PopupType type) {
//     switch (type) {
//       case PopupType.menu:
//         return MenuPop();
//       case PopupType.dialog:
//         return DialogPop();
//       case PopupType.bottomSheet:
//         return BottomPop();
//       default:
//         throw Exception('Unsupported Popup Type');
//     }
//   }
// }

class Pop {
  static Future<dynamic> pick(
      {required String title,
      required BuildContext context,
      required Offset position,
      required Iterable<ItemBase> options,
      dynamic selected,
      required PopupType type,
      required bool isMultiple}) async {
    final fac = Pop._create(type);
    if (isMultiple) {
      return await fac.pickMulti(
        context: context,
        title: title,
        position: position,
        options: options,
        selected: selected,
      );
    } else {
      return await fac.pickOne(
        context: context,
        title: title,
        position: position,
        options: options,
        selected: selected,
      );
    }
  }

  static BasePopup _create(PopupType type) {
    switch (type) {
      case PopupType.menu:
        return MenuPop();
      case PopupType.dialog:
        return DialogPop();
      case PopupType.bottomSheet:
        return BottomPop();
      default:
        throw Exception('Unsupported Popup Type');
    }
  }

  static Future<dynamic> pickDate(dynamic value) async {
    return await DateService.instance
        .pickDate(now: ConvertHelper.otherToDate(value));
  }
}
