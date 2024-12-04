import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/model/buy/nested_item.dart';
import 'package:openqrx/feature/shared/generic/abstract/generic_form_abstract.dart';
import 'package:openqrx/helper/form/product_helper.dart';

class ProductOperator extends StatelessWidget {
  final MapEntry<String, NestedItem> item;
  final GenericFormAbstract provider;
  final MapEntry<String, dynamic> e;
  const ProductOperator(this.item, this.provider, this.e, {super.key});
  Widget smallIcon({required Widget icon, required VoidCallback onTap}) {
    const double size = 36;
    return SizedBox(
      width: size,
      height: size,
      child: IconButton.filledTonal(
          iconSize: size / 2,
          onPressed: onTap,
          padding: EdgeInsets.zero,
          icon: icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    final unit = item.value.unit;

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: x12, top: x12, bottom: x12),
            child: Text.rich(
              TextSpan(children: [
                TextSpan(text: item.value.title),
                TextSpan(
                    text: ' (${item.value.getValue.toRiel} $unit)',
                    style: xGreyStyleLarge)
              ]),
              style: xStyle.labelLarge,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            smallIcon(
                onTap: () => provider.onSumQtyChanged(e.key, item.key, -1),
                icon: const Icon(
                  Icons.remove,
                )),
            Container(
              width: 30,
              alignment: Alignment.center,
              child: Text(
                '${item.value.quantity}',
                style: xStyle.labelLarge,
              ),
            ),
            smallIcon(
                onTap: () => provider.onSumQtyChanged(e.key, item.key, 1),
                icon: const Icon(
                  Icons.add,
                )),
          ],
        ),
        Container(
          width: 80,
          alignment: Alignment.centerRight,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              '${(item.value.getQuality * item.value.getValue).toRiel} $unit',
              style: xGreyStyleLarge,
            ),
          ),
        ),
      ],
    );
  }
}

class ProductTotal extends Text {
  final bool isSupply;
  final Iterable<NestedItem> list;
  ProductTotal(this.list, this.isSupply, {super.key})
      : super(
          '${ProductHelper.total(list).toRiel} ${list.first.unit}${isSupply ? ' ---- ${ProductHelper.totalQuantity(list).toRiel} Bags' : ''}',
          style: xStyle.titleMedium,
        );
}
