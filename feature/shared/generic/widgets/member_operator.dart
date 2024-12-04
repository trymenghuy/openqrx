import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:openqrx/domain/enum/worker_role.dart';
import 'package:openqrx/domain/model/buy/nested_item.dart';
import 'package:openqrx/feature/shared/generic/abstract/generic_form_abstract.dart';
import 'package:openqrx/feature/shared/widgets/form/app_input.dart';
import 'package:openqrx/feature/shared/widgets/form/input_style.dart';
import 'package:openqrx/feature/shared/widgets/pop/offset_pop.dart';
import 'package:openqrx/feature/shared/widgets/pop/pop_items.dart';
import 'package:openqrx/helper/form/convert_helper.dart';

class MemberOperator extends StatelessWidget {
  final MapEntry<String, NestedItem> item;
  final GenericFormAbstract provider;
  final MapEntry<String, dynamic> e;
  const MemberOperator(this.item, this.provider, this.e, {super.key});
  Widget smallIcon({required Widget icon, required VoidCallback onTap}) {
    return SizedBox(
      child: IconButton(
        iconSize: x20,
        onPressed: onTap,
        padding: EdgeInsets.zero,
        icon: icon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String? value = item.value.value as String?;
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(item.value.title),
          ),
        ),
        Container(
          width: 120,
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.symmetric(vertical: x5),
          child: OffsetPop(
            top: 0,
            clear: value.orIsEmpty
                ? const IconButton(onPressed: null, icon: InputDropDown())
                : IconButton(
                    onPressed: () {
                      provider.onNestInputChanged(e.key, item.key, null,
                          notify: true);
                    },
                    icon: Icon(
                      Icons.clear,
                      color: xColor.error,
                      size: x20,
                    )),
            onTab: (context, position) async {
              final result = await PopItems().show(
                  context: context,
                  title: 'Role',
                  position: position,
                  options: WorkerRole.values.map((e) => ItemBase.fromEnum(e)),
                  selected: item.value.value);
              if (result != null) {
                provider.onNestInputChanged(e.key, item.key, result,
                    notify: true);
              }
            },
            child: AppInput(
              key: Key(item.key),
              enabled: false,
              value: ConvertHelper.otherToString(item.value.value),
              decoration: InputStyle.border(
                  fillColor: xColor.secondaryContainer.withOpacity(0.5),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10)),
            ),
          ),
        ),
      ],
    );
  }
}
