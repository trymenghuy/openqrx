import 'package:openqrx/helper/form/convert_helper.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UsageInput {
  String? id;
  DateTime? receivedAt;
  UsageInput({
    this.id,
    this.receivedAt,
  });
  // static InputRule input = InputRule(
  //   id: 'usage',
  //   icons: {
  //     'receivedAt': SvgIcons.xCalendarDateBoldDuotone,
  //   },
  //   map: UsageInput.fromJson({}).toJson(),
  //   dynamicOption: {
  //     'feed': InputService().getFeeds,
  //   },
  //   skips: ['feed'],
  //   dates: ['receivedAt'],
  //   multiOptions: ['feed'],
  // );
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'receivedAt': receivedAt?.millisecondsSinceEpoch,
    };
  }

  factory UsageInput.fromJson(Map<String, dynamic> map) {
    return UsageInput(
      id: map['id'] != null ? map['id'] as String : null,
      receivedAt: ConvertHelper.otherToDate(map['receivedAt']),
    );
  }
}
