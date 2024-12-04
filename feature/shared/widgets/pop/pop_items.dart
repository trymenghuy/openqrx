import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:openqrx/feature/shared/widgets/pop/dialog_filter_items.dart';
import 'package:openqrx/helper/img_helper.dart';

class PopItems {
  Future<List<dynamic>?> showMulti({
    required String title,
    required BuildContext context,
    required Offset position,
    required Iterable<ItemBase> options,
    List<dynamic>? selectedOptions,
  }) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset offset = button.localToGlobal(Offset.zero);
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    Set<dynamic> tempSelectedOptions = Set.from(selectedOptions ?? []);
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        offset.dy,
        overlay.size.width - position.dx,
        overlay.size.height - position.dy,
      ),
      items: options.isEmpty
          ? emptyPopupMenuItem()
          : [
              titleItem(title, onTap: () async {
                final result = await DialogFilterItems().showMulti(
                    title: title,
                    context: context,
                    options: options,
                    selectedOptions: tempSelectedOptions);
                if (result != null) {
                  tempSelectedOptions = result;
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                }
              }),
              dividerItem,
              ...options.map(
                  (option) => _buildPopupMenuItem(option, tempSelectedOptions))
            ],
    );
    return tempSelectedOptions.isEmpty ? null : tempSelectedOptions.toList();
  }

  PopupMenuItem _buildPopupMenuItem(ItemBase e, Set<dynamic> selectedOptions) {
    final hasSubtitle = e.subtitle != null;
    return PopupMenuItem<Set<dynamic>>(
      value: selectedOptions,
      padding: EdgeInsets.zero,
      enabled: e.value != 'none',
      child: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          final isSelected = selectedOptions.contains(e.value);
          return ListTile(
            dense: true,
            minVerticalPadding: 0,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
            leading: Icon(
              isSelected ? Icons.check_box : Icons.check_box_outline_blank,
              color: xColor.primary,
            ),
            title: Text(
              e.title,
              style: xStyle.labelLarge,
            ),
            subtitle: hasSubtitle ? Text(e.subtitle!) : null,
            trailing: e.imageUrl.orIsNotEmpty
                ? ImgHelper.avatar(e.imageUrl, radius: x20)
                : null,
            onTap: () {
              setState(() {
                if (!isSelected) {
                  selectedOptions.add(e.value);
                } else {
                  selectedOptions.remove(e.value);
                }
              });
            },
          );
          // return CheckboxListTile(
          //   value: selectedOptions.contains(e.value),
          //   title: Text(
          //     e.title,
          //     style: xStyle.labelLarge,
          //   ),
          //   subtitle: hasSubtitle ? Text(e.subtitle!) : null,
          //   // trailing: e.imageUrl.orIsNotEmpty
          //   //     ? ImgHelper.avatar(e.imageUrl)
          //   //     : null,
          //   controlAffinity: ListTileControlAffinity.leading,
          //   dense: true,
          //   contentPadding: const EdgeInsets.only(left: 10, right: 20),
          //   onChanged: (bool? isSelected) {
          //     setState(() {
          //       if (isSelected == true) {
          //         selectedOptions.add(e.value);
          //       } else {
          //         selectedOptions.remove(e.value);
          //       }
          //     });
          //   },
          // );
        },
      ),
    );
  }

  PopupMenuItem titleItem(String title, {VoidCallback? onTap}) {
    return PopupMenuItem(
      enabled: false,
      padding: EdgeInsets.zero,
      height: 40,
      child: Container(
        height: 40,
        padding: const EdgeInsets.only(left: x20),
        constraints: const BoxConstraints(minWidth: 150),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: xStyle.titleMedium,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: onTap,
            ),
          ],
        ),
      ),
    );
  }

  PopupMenuItem dividerItem = const PopupMenuItem(
    enabled: false,
    height: 16,
    padding: EdgeInsets.zero,
    child: Divider(
      indent: 0,
      endIndent: 0,
    ),
  );
  List<PopupMenuItem> emptyPopupMenuItem() => [
        PopupMenuItem(
            height: 100,
            child: Container(
              width: 200,
              alignment: Alignment.center,
              child: const Icon(
                Icons.storefront_sharp,
                size: 40,
              ),
            ))
      ];

  Future<dynamic> show({
    required String title,
    required BuildContext context,
    required Offset position,
    required Iterable<ItemBase> options,
    dynamic selected,
  }) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset offset = button.localToGlobal(Offset.zero);
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;

    final result = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        offset.dy - 60,
        overlay.size.width - position.dx,
        overlay.size.height - position.dy,
      ),
      items: options.isEmpty
          ? emptyPopupMenuItem()
          : [
              titleItem(title, onTap: () async {
                // Navigator.of(context).pop();
                final result = await DialogFilterItems().show(
                    title: title,
                    context: context,
                    options: options,
                    selected: selected);
                if (result != null) {
                  selected = result;
                  if (context.mounted) {
                    Navigator.of(context).pop(selected);
                  }
                }
              }),
              dividerItem,
              ...options.map((e) {
                final hasSubtitle = e.subtitle != null;
                final bool isSelected = e.value == selected;
                final h = (hasSubtitle ? 60 : 54).toDouble();
                return PopupMenuItem(
                  value: e.value,
                  height: h,
                  padding: EdgeInsets.zero,
                  enabled: e.value != 'none',
                  child: SizedBox(
                    height: h,
                    child: ListTile(
                      dense: true,
                      minVerticalPadding: 0,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 0),
                      leading: Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_off,
                        color: xColor.primary,
                      ),
                      title: Text(
                        e.title,
                        style: xStyle.labelLarge,
                      ),
                      subtitle: hasSubtitle ? Text(e.subtitle!) : null,
                      trailing: e.imageUrl.orIsNotEmpty
                          ? ImgHelper.avatar(e.imageUrl, radius: x20)
                          : null,
                    ),
                  ),
                );
              }),
            ],
    );
    return result;
  }
}
