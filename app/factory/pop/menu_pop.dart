import 'package:flutter/material.dart';
import 'package:openqrx/app/constants/svg.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/factory/pop/base_pop.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:openqrx/feature/shared/widgets/svg_icon.dart';
import 'package:openqrx/feature/shared/widgets/title.dart';
import 'package:openqrx/helper/img_helper.dart';

class MenuPop implements BasePopup {
  @override
  Future<dynamic> pickOne({
    required String title,
    required BuildContext context,
    required Offset position,
    required Iterable<ItemBase> options,
    dynamic selected,
  }) async {
    final result = await _pop(
        title: title,
        context: context,
        position: position,
        options: options,
        builder: (e) {
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
                selected: isSelected,
                selectedTileColor: xColor.surfaceContainerHighest,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
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
        });
    return result;
  }

  Future<dynamic> _pop({
    required String title,
    required BuildContext context,
    required Offset position,
    required Iterable<ItemBase> options,
    required PopupMenuEntry Function(ItemBase) builder,
  }) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset offset = button.localToGlobal(Offset.zero);
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    return await showMenu(
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
              titleMenuItem(title, onTap: null),
              dividerItem,
              ...options.map((option) => builder(option))
            ],
    );
  }

  @override
  Future<List<dynamic>?> pickMulti({
    required String title,
    required BuildContext context,
    required Offset position,
    required Iterable<ItemBase> options,
    List<dynamic>? selected,
  }) async {
    Set<dynamic> tempSelected = Set.from(selected ?? []);
    await _pop(
        title: title,
        context: context,
        position: position,
        options: options,
        builder: (option) => _buildPopupMenuItem(option, tempSelected));
    return tempSelected.toList();
    // return tempSelected.isEmpty ? null : tempSelected.toList();
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
            selected: isSelected,
            selectedTileColor: xColor.surfaceContainerHighest,
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
        },
      ),
    );
  }

  PopupMenuItem titleMenuItem(String title, {VoidCallback? onTap}) {
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
              child: TitleLg(title),
            ),
            onTap == null
                ? space15
                : IconButton(
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
              child: const SvgIcon(
                SvgIcons.xEarthBoldDuotone,
                size: 40,
              ),
            ))
      ];
}
