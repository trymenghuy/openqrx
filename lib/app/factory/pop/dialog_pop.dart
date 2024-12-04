import 'package:flutter/material.dart';
import 'package:openqrx/app/factory/pop/base_pop.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/enum/item_base.dart';

class DialogPop implements BasePopup {
  @override
  Future<dynamic> pickOne(
      {required String title,
      required BuildContext context,
      required Offset position,
      required Iterable<ItemBase> options,
      selected}) async {
    dynamic selectedValue = selected;
    await showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return buildDialog(
              title: title,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: options.map((e) {
                  final isSelected = e.value == selectedValue;
                  return RadioListTile<dynamic>(
                    title: Text(e.title),
                    value: e.value,
                    groupValue: selectedValue,
                    selected: isSelected,
                    selectedTileColor: xColor.surfaceContainerHighest,
                    onChanged: (value) {
                      setState(() {
                        selectedValue = value;
                      });
                      // Return the selected value and close the Bottom Sheet
                      // Navigator.pop(context, value);
                    },
                  );
                }).toList(),
              ),
            );
          },
        );
      },
    );
    return selectedValue;
  }

  Widget buildDialog({required String title, required Widget child}) {
    return AlertDialog(
      title: buildTitle(title),
      titlePadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      contentPadding:
          const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 0),
      content: child,
    );
  }

  Widget buildTitle(String title) {
    return Text(
      title,
      style: xStyle.headlineSmall,
    );
  }

  @override
  Future<dynamic> pickMulti(
      {required String title,
      required BuildContext context,
      required Offset position,
      required Iterable<ItemBase> options,
      List? selected}) async {
    Set<dynamic> tempSelected = Set.from(selected ?? []);
    await showDialog<dynamic>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return buildDialog(
                title: title,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: options.map((e) {
                    final isSelected = tempSelected.contains(e.value);
                    return CheckboxListTile(
                      title: Text(e.title),
                      selected: isSelected,
                      selectedTileColor: xColor.surfaceContainerHighest,
                      value: isSelected,
                      onChanged: (value) {
                        if (isSelected) {
                          tempSelected.remove(e.value);
                        } else {
                          tempSelected.add(e.value);
                        }
                        setState(() {});
                      },
                    );
                  }).toList(),
                ));
          },
        );
      },
    );
    return tempSelected.toList();
    // return tempSelected.isEmpty ? null : tempSelected.toList();
  }
}
