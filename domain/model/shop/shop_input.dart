// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:openqrx/domain/enum/lend_reason.dart';
import 'package:openqrx/domain/model/input_rule.dart';

class ShopInput {
  String? id;
  String? username;
  String? name;
  String? description;
  String? imageUrl;
  ShopInput({
    this.id,
    this.username,
    this.name,
    this.description,
    this.imageUrl,
  });

  static InputRule input = InputRule(
    id: 'Shop',
    // icons: {
    //   'username': SvgIcons.xUserBlockBoldDuotone,
    //   'name': SvgIcons.xNotebookBoldDuotone,
    //   'value': SvgIcons.xDollarBoldDuotone
    // },
    map: ShopInput.fromJson({}).toJson(),
    files: ['imageUrl'],
    digits: ['value'],
    option: {'name': LendReason.values.map((e) => ItemBase.fromEnum(e))},
  );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory ShopInput.fromJson(Map<String, dynamic> map) {
    return ShopInput(
      id: map['id'] != null ? map['id'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
    );
  }
}
