import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/service/date_service.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:openqrx/domain/model/buy/buy.dart';
import 'package:openqrx/feature/shared/buy/buy_form.dart';
import 'package:openqrx/feature/shared/generic/generic_page.dart';
import 'package:openqrx/feature/shared/widgets/table/right_text.dart';
import 'package:openqrx/feature/shared/widgets/table/table_opt_wrap.dart';
import 'package:openqrx/helper/form/product_helper.dart';

class BuyPage extends StatelessWidget {
  const BuyPage({super.key});

  @override
  Widget build(BuildContext context) {
    const divider = Divider(
      height: x15,
      endIndent: 0,
      indent: 0,
    );
    const unit = '៛';
    return GenericPage<Buy>(
        collection: 'Buy',
        form: (map) => BuyForm(map: map),
        fromJson: Buy.fromJson,
        toJson: (data) => data.toJson(),
        itemBuilder: (e, editButton, deleteButton) {
          ItemBase? profile;
          if (e.other?['uid'] != null) {
            profile = ItemBase.fromJson(e.other?['uid']);
          }
          return TableOptWrap(
            options: [deleteButton(e, title: profile?.title)],
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    profile?.title ?? e.uid,
                    style: xStyle.titleMedium,
                  ),
                  Text(
                    DateService.instance.fullText(e.createdAt),
                    style: xGreyStyleMedium,
                  ),
                ],
              ),
              space10,
              Table(
                border: const TableBorder(),
                columnWidths: const <int, TableColumnWidth>{
                  0: FlexColumnWidth(),
                  1: FixedColumnWidth(80),
                  2: FixedColumnWidth(50),
                  3: FixedColumnWidth(100),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: e.product.entries
                    .map((e) => TableRow(
                            decoration: const BoxDecoration(border: Border()),
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  e.value.title,
                                ),
                              ),
                              RightText((e.value.getValue.orZero).toRiel),
                              RightText(e.value.getQuality.toString()),
                              RightText(
                                  '${(e.value.getValue.orZero * e.value.getQuality).toRiel} $unit'),
                            ]))
                    .toList(),
              ),
              divider,
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  '${ProductHelper.total(e.product.values).toRiel} $unit',
                  style: xStyle.labelLarge?.copyWith(color: xColor.error),
                ),
              )
            ],
          );
        });
  }
}
