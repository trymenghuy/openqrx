import 'package:flutter/material.dart';
import 'package:openqrx/app/service/date_service.dart';
import 'package:openqrx/app/util/navigator.dart';
import 'package:openqrx/app/util/print.dart';
import 'package:openqrx/feature/shared/usage/usage_form.dart';
import 'package:openqrx/feature/shared/widgets/buttons/long_button.dart';

class UsagePickDatePage extends StatefulWidget {
  const UsagePickDatePage({super.key});

  @override
  State<UsagePickDatePage> createState() => _UsagePickDatePageState();
}

class _UsagePickDatePageState extends State<UsagePickDatePage> {
  DateTime? dateTime;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => pickDate());
  }

  void pickDate() async {
    final date = await DateService.instance.pickDate();
    if (date != null) {
      setState(() {
        dateTime = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick Usage Date'),
      ),
      body: Center(
        child: FilledButton(
          child: Text(dateTime != null
              ? DateService.instance.dateToFullDay(dateTime)
              : 'Pick Date'),
          onPressed: () {
            pickDate();
          },
        ),
      ),
      bottomNavigationBar: dateTime != null
          ? LongButton(
              onTap: () {
                xPrint(dateTime);
                XNavigator.push(UsageForm(receivedAt: dateTime!));
              },
            )
          : null,
    );
  }
}
