// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:openqrx/domain/model/buy/nested_item.dart';
import 'package:openqrx/helper/form/convert_helper.dart';

class Supply implements Identifiable {
  @override
  final String id;
  final Map<String, NestedItem> feed;
  final DateTime receivedAt;
  final String? note;
  final String? createdBy;
  final DateTime? updatedAt;
  Supply(
      {required this.id,
      required this.feed,
      required this.receivedAt,
      this.note,
      this.createdBy,
      this.updatedAt});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'feed': feed.keys.toList(),
      'receivedAt': receivedAt,
      'note': note,
      'createdBy': createdBy,
      'updatedAt': updatedAt,
      'other': {
        'nestedInput': {'feed': feed},
      }
    };
  }

  factory Supply.fromJson(Map<String, dynamic> map) {
    return Supply(
      id: map['id'] as String,
      createdBy: map['createdBy'] as String?,
      feed: Map<String, dynamic>.from((map['feed'] as Map<String, dynamic>))
          .map((key, value) => MapEntry(key, NestedItem.fromJson(value))),
      receivedAt: ConvertHelper.otherToDate(map['receivedAt'])!,
      updatedAt:
          ConvertHelper.otherToDate(map['updatedAt'] ?? map['createdAt'])!,
      note: map['note'] != null ? map['note'] as String : null,
    );
  }
}
