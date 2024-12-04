// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:openqrx/domain/model/buy/nested_item.dart';
import 'package:openqrx/helper/form/convert_helper.dart';

class Buy implements Identifiable {
  @override
  final String id;
  final String uid;
  final Map<String, NestedItem> product;
  final DateTime createdAt;
  final Map<dynamic, dynamic>? other;
  final String? note;

  Buy({
    required this.id,
    required this.uid,
    required this.product,
    required this.createdAt,
    this.other,
    this.note,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'product': product,
      'createdAt': createdAt,
      'other': other,
      'note': note,
    };
  }

  factory Buy.fromJson(Map<String, dynamic> map) {
    return Buy(
      id: map['id'] as String,
      uid: map['uid'] as String,
      product:
          Map<String, dynamic>.from((map['product'] as Map<String, dynamic>))
              .map((key, value) => MapEntry(key, NestedItem.fromJson(value))),
      createdAt: ConvertHelper.otherToDate(map['createdAt'])!,
      other:
          map['other'] != null ? map['other'] as Map<dynamic, dynamic> : null,
      note: map['note'] != null ? map['note'] as String : null,
    );
  }

  @override
  bool operator ==(covariant Buy other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
