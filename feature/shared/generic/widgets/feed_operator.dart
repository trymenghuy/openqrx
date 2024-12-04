import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/model/buy/nested_item.dart';
import 'package:openqrx/feature/shared/generic/abstract/generic_form_abstract.dart';
import 'package:openqrx/feature/shared/generic/widgets/remove_nested_icon.dart';
import 'package:openqrx/feature/shared/widgets/form/app_input.dart';
import 'package:openqrx/feature/shared/widgets/form/input_style.dart';
import 'package:openqrx/helper/form/convert_helper.dart';
import 'package:openqrx/helper/form/format_helper.dart';

class FeedOperator extends StatelessWidget {
  final MapEntry<String, NestedItem> item;
  final GenericFormAbstract provider;
  final MapEntry<String, dynamic> e;
  const FeedOperator(this.item, this.provider, this.e, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RemoveNestedIcon(onTap: () {
          provider.removeNestedQtyInput(e.key, item.key);
        }),
        Expanded(
          child: Text.rich(
            TextSpan(children: [
              TextSpan(text: item.value.title),
              TextSpan(
                  text: ' (${item.value.getValue.toRiel} ${item.value.unit})',
                  style: xGreyStyleLarge)
            ]),
            style: xStyle.labelLarge,
          ),
        ),
        Container(
          width: 100,
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.symmetric(vertical: x5),
          child: AppInput(
            key: Key(item.key),
            inputFormatters: FormatHelper.digitOnly,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.right,
            onChanged: (value) {
              provider.onQtyChanged(e.key, item.key, int.tryParse(value) ?? 0);
            },
            value: ConvertHelper.otherToString(item.value.quantity),
            decoration: InputStyle.border(
                hintText: 'Bag',
                fillColor: xColor.secondaryContainer.withOpacity(0.5),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: x10)),
          ),
        ),
      ],
    );
  }
}
