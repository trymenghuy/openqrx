import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/service/date_service.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/model/feed/supply.dart';
import 'package:openqrx/feature/shared/generic/generic_page.dart';
import 'package:openqrx/feature/shared/supply/supply_form.dart';
import 'package:openqrx/feature/shared/widgets/table/right_text.dart';
import 'package:openqrx/feature/shared/widgets/table/table_opt_wrap.dart';
import 'package:openqrx/helper/form/product_helper.dart';

class SupplyPage extends StatelessWidget {
  const SupplyPage({super.key});

  @override
  Widget build(BuildContext context) {
    const divider = Divider(
      height: x15,
      endIndent: 0,
      indent: 0,
    );
    const unit = 'Kg';
    return GenericPage<Supply>(
        collection: 'Supply',
        form: (map) => SupplyForm(map: map),
        isTotal: true,
        toJson: (data) => data.toJson(),
        fromJson: Supply.fromJson,
        sortedBy: (p0) => p0.sortedBy((e) => e.receivedAt),
        itemBuilder: (e, editButton, deleteButton) => TableOptWrap(
              options: [editButton(e), deleteButton(e)],
              children: [
                Text(
                  DateService.instance.dateToFullDay(e.receivedAt),
                  style: xStyle.titleMedium,
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
                  children: e.feed.entries
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
                                RightText('${e.value.getValue.toRiel} $unit'),
                                RightText(e.value.quantity.toString()),
                                RightText(
                                    '${(e.value.getValue * e.value.getQuality).toRiel} $unit'),
                              ]))
                      .toList(),
                ),
                divider,
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    '${ProductHelper.total(e.feed.values).toRiel} $unit',
                    style: xStyle.labelLarge?.copyWith(color: xColor.error),
                  ),
                )
              ],
            ));
  }
}
