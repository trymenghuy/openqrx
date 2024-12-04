import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/model/buy/nested_item.dart';
import 'package:openqrx/feature/shared/generic/abstract/generic_form_abstract.dart';
import 'package:openqrx/feature/shared/widgets/form/app_input.dart';
import 'package:openqrx/feature/shared/widgets/form/input_style.dart';
import 'package:openqrx/helper/form/convert_helper.dart';

class PigstyOperator extends StatelessWidget {
  final MapEntry<String, NestedItem> item;
  final GenericFormAbstract provider;
  final MapEntry<String, dynamic> e;
  const PigstyOperator(this.item, this.provider, this.e, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(item.value.title),
          ),
        ),
        Container(
          width: 100,
          alignment: Alignment.centerRight,
          margin: const EdgeInsets.symmetric(vertical: x5),
          child: AppInput(
            key: Key(item.key),
            onChanged: (value) {
              provider.onNestInputChanged(e.key, item.key, value);
            },
            value: ConvertHelper.otherToString(item.value.value),
            decoration: InputStyle.border(
                fillColor: xColor.secondaryContainer.withOpacity(0.5),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: x10)),
          ),
        ),
      ],
    );
  }
}
