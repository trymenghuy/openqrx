import 'package:flutter/material.dart';
import 'package:openqrx/app/service/date_service.dart';
import 'package:openqrx/app/util/txt.dart';

class DateButton extends StatelessWidget {
  final DateTime? now;
  final Function(DateTime)? onTap;
  const DateButton({super.key, this.now, this.onTap});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        color: xColor.tertiary,
        onPressed: () async {
          final date = await DateService.instance.pickDate(now: now);
          if (date != null) {
            onTap?.call(date);
          }
        },
        textColor: xColor.onTertiary,
        child: Row(
          children: [
            Text(
              DateService.instance.dateToDay(now),
            ),
            space5,
            const Icon(
              Icons.calendar_month,
              size: 16,
            )
          ],
        ));
  }
}
