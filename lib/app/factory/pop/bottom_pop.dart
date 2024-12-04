import 'package:flutter/material.dart';
import 'package:openqrx/app/factory/pop/base_pop.dart';
import 'package:openqrx/app/factory/pop/bottom_sliver_appbar.dart';
import 'package:openqrx/app/util/print.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/enum/item_base.dart';

class BottomPop implements BasePopup {
  @override
  Future<dynamic> pickOne(
      {required String title,
      required BuildContext context,
      required Offset position,
      required Iterable<ItemBase> options,
      selected}) async {
    dynamic selectedValue = selected;
    int? selectedIndex;
    for (final e in options.toList().asMap().entries) {
      if (e.value.value == selectedValue) {
        selectedIndex = e.key + 1;
        break;
      }
    }
// final selectedIndex = options.toList().indexWhere((option) => option.value == selectedValue) + 1;
    await showBottom(
        builder: (e, setState) {
          final isSelected = e.value == selectedValue;
          return RadioListTile<dynamic>(
            title: Text(e.title),
            selected: isSelected,
            selectedTileColor: xColor.surfaceContainerHighest,
            value: e.value,
            groupValue: selectedValue,
            onChanged: (value) async {
              setState(() {
                selectedValue = value;
              });
              await Future.delayed(const Duration(milliseconds: 200));
              if (context.mounted) {
                Navigator.pop(context, value);
              }
            },
          );
        },
        context: context,
        options: options,
        title: title,
        selectedIndex: selectedIndex);
    return selectedValue;
  }

  Future<dynamic> showBottom({
    required String title,
    required BuildContext context,
    required Iterable<ItemBase> options,
    required Widget Function(ItemBase, StateSetter) builder,
    int? selectedIndex,
  }) async {
    DraggableScrollableController controller = DraggableScrollableController();
    final screenHeight = xSize.height;
    double maxChildSize = 1;
    double initialChildSize = 0.6;
    double? offset;
    final height = (options.length * 54.0) + (xPad.bottom) + kToolbarHeight;
    if (height < screenHeight) {
      maxChildSize = height / screenHeight;
      initialChildSize = maxChildSize;
    } else {
      if (selectedIndex != null) {
        final y = 54.0 * (selectedIndex) - (screenHeight * 0.4);
        if (y > 0) {
          offset = y;
          initialChildSize = maxChildSize;
        }
      }
    }
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // showDragHandle: true,
      useSafeArea: true,
      builder: (context) {
        return DraggableScrollableSheet(
          controller: controller,
          maxChildSize: maxChildSize,
          initialChildSize: initialChildSize,
          expand: false,
          builder: (context, scrollController) {
            return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Card(
                color: xColor.surface,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                margin: EdgeInsets.zero,
                child: CustomScrollView(
                  controller: scrollController,
                  scrollBehavior: ScrollConfiguration.of(context)
                      .copyWith(overscroll: false),
                  // physics: const BouncingScrollPhysics(),
                  slivers: [
                    BottomSliverAppBar(
                      controller: controller,
                      maxChildSize: maxChildSize,
                      initialChildSize: initialChildSize,
                      title: title,
                      onInitSelected: offset == null
                          ? null
                          : () {
                              xPrint(
                                  'offset $offset screenHeight $screenHeight');
                              scrollController.animateTo(offset!,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInCirc);
                            },
                      // initialChildSize: selectedChildSize,
                      // scrollController: scrollController
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final e = options.elementAt(index);
                          return builder(e, setState);
                        },
                        childCount:
                            options.length, // Adjust this number as needed
                      ),
                    ),
                  ],
                ),
              );
            });
          },
        );
      },
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
    int? selectedIndex;
    for (final e in options.toList().asMap().entries) {
      if (tempSelected.contains(e.value.value)) {
        selectedIndex = e.key + 1;
        break;
      }
    }
    await showBottom(
      builder: (e, setState) {
        final isSelected = tempSelected.contains(e.value);
        return CheckboxListTile(
          title: Text(e.title),
          selected: isSelected,
          selectedTileColor: xColor.surfaceContainerHighest,
          // tileColor: Colors.transparent,
          controlAffinity: ListTileControlAffinity.leading,
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
      },
      context: context,
      options: options,
      title: title,
      selectedIndex: selectedIndex,
    );

    return tempSelected.toList();
    // return tempSelected.isEmpty ? null : tempSelected.toList();
  }
}
