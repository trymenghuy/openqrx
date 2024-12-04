// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:openqrx/domain/model/buy/nested_item.dart';

class Farm implements Identifiable {
  @override
  final String id;
  final String title;
  final String? username;
  final String? imageUrl;
  final Map<String, NestedItem> member;
  Farm({
    required this.id,
    required this.title,
    this.username,
    this.imageUrl,
    required this.member,
  });
  String get url => 'https://tmh-pos.web.app/shop/$username';
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'username': username,
      'imageUrl': imageUrl,
      'member': member.keys.toList(),
      'other': {
        'nestedInput': {'member': member},
      }
    };
  }

  factory Farm.fromJson(Map<String, dynamic> map) {
    return Farm(
      id: map['id'] as String,
      title: map['title'] as String,
      imageUrl: map['imageUrl'] as String?,
      username: map['username'] as String?,
      member: Map<String, dynamic>.from((map['member'] ?? {}))
          .map((key, value) => MapEntry(key, NestedItem.fromJson(value))),
    );
  }
}
