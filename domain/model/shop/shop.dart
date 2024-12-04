// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:openqrx/domain/enum/item_base.dart';

class Shop extends Identifiable {
  @override
  String id;
  String username;
  String name;
  String description;
  String imageUrl;
  Shop({
    required this.id,
    required this.username,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory Shop.fromJson(Map<String, dynamic> map) {
    return Shop(
      id: map['id'] as String,
      username: map['username'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }
}
