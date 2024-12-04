// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:openqrx/helper/form/convert_helper.dart';

class Lend implements Identifiable {
  @override
  final String id;
  final String uid;
  final String title;
  final num value;
  final Map<String, dynamic>? other;
  final DateTime createdAt;
  Lend({
    required this.id,
    required this.uid,
    required this.title,
    required this.value,
    required this.createdAt,
    this.other,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'title': title,
      'value': value,
      'createdAt': createdAt,
      'other': other,
    };
  }

  factory Lend.fromJson(Map<String, dynamic> map) {
    return Lend(
      id: map['id'] as String,
      uid: map['uid'] as String,
      title: map['title'] as String,
      value: map['value'] as num,
      createdAt: ConvertHelper.otherToDate(map['createdAt'])!,
      other: map['other'] != null
          ? Map<String, dynamic>.from((map['other']))
          : null,
    );
  }

  @override
  bool operator ==(covariant Lend other) {
    if (identical(this, other)) return true;
    return other.id == id;
  }

  @override
  int get hashCode {
    return id.hashCode;
  }
}
