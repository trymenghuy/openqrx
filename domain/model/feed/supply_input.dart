import 'package:openqrx/app/constants/svg.dart';
import 'package:openqrx/domain/model/input_rule.dart';
import 'package:openqrx/feature/shared/generic/widgets/feed_operator.dart';
import 'package:openqrx/helper/form/convert_helper.dart';
import 'package:openqrx/helper/service/input_service.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SupplyInput {
  String? id;
  Map<String, dynamic>? feed;
  DateTime? receivedAt;
  String? note;
  SupplyInput({
    this.id,
    this.feed,
    this.receivedAt,
    this.note,
  });
  static InputRule input = InputRule(
      id: 'supply',
      icons: {
        'note': SvgIcons.xNotebookBoldDuotone,
        'receivedAt': SvgIcons.xCalendarDateBoldDuotone,
        'feed': SvgIcons.xArchiveMinimalisticBoldDuotone,
      },
      map: SupplyInput.fromJson({}).toJson(),
      dynamicOption: {
        'feed': InputService().getFeeds,
      },
      dates: ['receivedAt'],
      multiOptions: ['feed'],
      optionals: ['note'],
      nestedOptions: {
        'feed': (item, provider, entry) => FeedOperator(item, provider, entry)
      });
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'feed': feed,
      'receivedAt': receivedAt?.millisecondsSinceEpoch,
      'note': note,
    };
  }

  factory SupplyInput.fromJson(Map<String, dynamic> map) {
    return SupplyInput(
      id: map['id'] != null ? map['id'] as String : null,
      feed: map['feed'] != null
          ? Map<String, dynamic>.from((map['feed'] as Map<String, dynamic>))
          : null,
      receivedAt: ConvertHelper.otherToDate(map['receivedAt']),
      note: map['note'] != null ? map['note'] as String : null,
    );
  }
}
