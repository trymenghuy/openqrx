import 'package:flutter/material.dart';
import 'package:openqrx/app/constants/svg.dart';
import 'package:openqrx/app/service/date_service.dart';
import 'package:openqrx/app/util/print.dart';
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:openqrx/domain/model/feed/usage_input.dart';
import 'package:openqrx/domain/model/input_rule.dart';
import 'package:openqrx/domain/model/map_form.dart';
import 'package:openqrx/feature/shared/generic/generic_form.dart';
import 'package:openqrx/feature/shared/generic/widgets/feed_operator.dart';
import 'package:openqrx/helper/service/input_service.dart';

class UsageForm extends MapForm {
  final DateTime receivedAt;
  const UsageForm({super.key, super.map, required this.receivedAt});
  Widget scaffold({required Widget child}) {
    return Scaffold(
      body: Center(child: child),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: InputService().getPens(),
      builder: (BuildContext context,
          AsyncSnapshot<(List<ItemBase>, List<ItemBase>)> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return scaffold(child: const CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data == null) {
          return scaffold(child: Text("Error: ${snapshot.error}"));
        } else {
          final pen = snapshot.data!.$1;
          final feed = snapshot.data!.$2;
          Map<String, Iterable<ItemBase>> option = {};
          Map<String, dynamic> field = {};
          Map<String, dynamic> translate = {};
          Map<String, String> icons = {
            'receivedAt': SvgIcons.xCalendarDateBoldDuotone,
          };
          Map<String, OperatorBuilder> nestedOptions = {};
          for (final e in pen) {
            option[e.value] = feed;
            field[e.value] = null;
            translate[e.value] = e.title;
            // icons[e.value] = SvgIcons.xPig;
            nestedOptions[e.value] =
                (item, provider, entry) => FeedOperator(item, provider, entry);
          }
          return GenericForm(
            appBar: AppBar(title: const Text('Usage')),
            translate: translate,
            input: InputRule(
              id: 'usage',
              icons: icons,
              description: DateService.instance.dateToFullDay(receivedAt),
              map: UsageInput.fromJson({}).toJson()..addAll(field),
              option: option,
              skips: ['receivedAt'],
              multiOptions: pen.map((e) => e.value as String).toList(),
              nestedOptions: nestedOptions,
            ),
            map: map,
            onSubmit: (map) {
              // DateService.instance.dayId(map['receivedAt']);
              // dayId
              xPrint(map);
            },
          );
        }
      },
    );
  }
}
