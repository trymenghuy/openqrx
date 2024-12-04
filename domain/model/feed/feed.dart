// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:openqrx/domain/enum/feed_net.dart';
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:openqrx/domain/enum/week_feed.dart';

class Feed extends Identifiable {
  @override
  final String id;
  final WeekFeed week;
  final String title;
  final FeedNet net;
  Feed({
    required this.id,
    required this.week,
    required this.title,
    required this.net,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'week': week.value,
      'title': title,
      'net': net.value,
    };
  }

  factory Feed.fromJson(Map<String, dynamic> map) {
    return Feed(
      id: map['id'] as String,
      week: WeekFeed.from(map['week']),
      title: map['title'] as String,
      net: FeedNet.from(map['net']),
    );
  }
}
