// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:openqrx/domain/model/input_rule.dart';

class UserInput {
  String? id;
  String? name;
  String? imageUrl;

  UserInput({this.id, this.name, this.imageUrl});
  static InputRule input = InputRule(
      id: 'user',
      map: UserInput.fromJson({}).toJson(),
      optionals: ['imageUrl'],
      files: ['imageUrl']);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
      'id': id,
      'name': name,
    };
  }

  factory UserInput.fromJson(Map<String, dynamic> map) {
    return UserInput(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['kh'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
    );
  }
}
