import 'package:openqrx/app/constants/svg.dart';
import 'package:openqrx/domain/enum/feed_net.dart';
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:openqrx/domain/enum/week_feed.dart';
import 'package:openqrx/domain/model/input_rule.dart';

class FeedInput {
  String? id;
  int? week;
  String? title;
  FeedNet? net;
  FeedInput({this.id, this.week, this.title, this.net});
  static InputRule input = InputRule(
    id: 'feed',
    icons: {
      'title': SvgIcons.xNotebookBoldDuotone,
      'week': SvgIcons.xCalendarDateBoldDuotone
    },
    map: FeedInput.fromJson({}).toJson(),
    option: {
      'net': FeedNet.values.map((e) => ItemBase.fromEnum(e)),
      'week': WeekFeed.values.map((e) => ItemBase.fromEnum(e))
    },
  );
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'net': net?.value,
      'week': week,
    };
  }

  factory FeedInput.fromJson(Map<String, dynamic> map) {
    return FeedInput(
      id: map['id'] != null ? map['id'] as String : null,
      week: map['week'] != null ? map['week'] as int : null,
      title: map['title'] != null ? map['title'] as String : null,
      net: FeedNet.from(map['net']),
    );
  }
}
