import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/enum/item_base.dart';

class DialogFilterItems {
  Widget getAnimation({required animation1, required Widget child}) => SafeArea(
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1), // Start from bottom
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation1,
              curve: Curves.easeOutQuad,
              reverseCurve: Curves.easeInQuad,
            ),
          ),
          child: child,
        ),
      );
  Future<Set<String>?> showMulti({
    required String title,
    required BuildContext context,
    required Iterable<ItemBase> options,
    Set<dynamic> selectedOptions = const {},
  }) async {
    return showGeneralDialog<Set<String>>(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, animation1, animation2, child) {
        String filterText = '';
        Set<String> tempSelectedOptions = Set.from(selectedOptions);
        return getAnimation(
          animation1: animation1,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                insetPadding: EdgeInsets.zero,
                // insetPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Scaffold(
                  // backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    // backgroundColor: Colors.transparent,
                    toolbarHeight: 64,
                    title: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search $title...',
                        border: InputBorder.none,
                      ),
                      autofocus: true,
                      onChanged: (value) {
                        setState(() {
                          filterText = value;
                        });
                      },
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: x10),
                        child: FilledButton(
                          child: const Text(
                            'OK',
                          ),
                          onPressed: () =>
                              Navigator.of(context).pop(tempSelectedOptions),
                        ),
                      ),
                    ],
                    shape: Border(bottom: borderSide05),
                  ),
                  body: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    children: options
                        .where((option) => option.title
                            .toLowerCase()
                            .contains(filterText.toLowerCase()))
                        .map((option) => CheckboxListTile(
                              value: tempSelectedOptions.contains(option.value),
                              title: Text(option.title),
                              // checkboxShape: ,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (bool? isSelected) {
                                setState(() {
                                  if (isSelected == true) {
                                    tempSelectedOptions.add(option.value);
                                  } else {
                                    tempSelectedOptions.remove(option.value);
                                  }
                                });
                              },
                            ))
                        .toList(),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Future<String?> show({
    required String title,
    required BuildContext context,
    required Iterable<ItemBase> options,
    String? selected,
  }) async {
    return showGeneralDialog<String>(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return Container();
      },
      transitionBuilder: (context, animation1, animation2, child) {
        String filterText = '';
        // Set<String> tempSelectedOptions = Set.from(selectedOptions);
        return getAnimation(
          animation1: animation1,
          child: StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                insetPadding: EdgeInsets.zero,
                // insetPadding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Scaffold(
                  // backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    // backgroundColor: Colors.transparent,
                    toolbarHeight: 64,
                    title: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search $title...',
                        border: InputBorder.none,
                      ),
                      autofocus: true,
                      onChanged: (value) {
                        setState(() {
                          filterText = value;
                        });
                      },
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: x10),
                        child: FilledButton(
                          child: const Text(
                            'OK',
                          ),
                          onPressed: () => Navigator.of(context).pop(selected),
                        ),
                      ),
                    ],
                    shape: Border(bottom: borderSide05),
                  ),
                  body: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    children: options
                        .where((option) => option.title
                            .toLowerCase()
                            .contains(filterText.toLowerCase()))
                        .map((option) => RadioListTile<String>(
                              value: option.value,
                              title: Text(option.title),
                              groupValue: selected,
                              // checkboxShape: ,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (String? value) {
                                setState(() {
                                  selected = value;
                                });
                              },
                            ))
                        .toList(),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
