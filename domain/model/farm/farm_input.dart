// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:openqrx/domain/model/buy/nested_item.dart';
import 'package:openqrx/domain/model/input_rule.dart';
import 'package:openqrx/feature/shared/generic/widgets/member_operator.dart';
import 'package:openqrx/helper/service/input_service.dart';

class FarmInput {
  final String? id;
  String? title;
  String? username;
  String? imageUrl;
  Map<String, dynamic>? member;

  FarmInput({this.id, this.title, this.member, this.username, this.imageUrl});
  static InputRule input = InputRule(
    id: 'farm',
    icons: {
      // 'title': SvgIcons.xUserBlockBoldDuotone,
    },
    map: FarmInput.fromJson({}).toJson(),
    option: {'member': []},
    optionals: ['member', 'imageUrl'],
    multiOptions: ['member'],
    files: ['imageUrl'],
    nestedOptMapper: {
      'member': (e) => NestedItem(title: e.title, value: e.value)
    },
    dynamicOption: {'member': InputService().getUsers},
    nestedOptions: {
      'member': (item, provider, entry) =>
          MemberOperator(item, provider, entry),
    },

    // nestedOptions: ['pigsty', 'member'],
  );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'username': username,
      'member': member,
    };
  }

  factory FarmInput.fromJson(Map<String, dynamic> map) {
    return FarmInput(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      member: map['member'] != null
          ? Map<String, dynamic>.from(map['member'])
          : null,
    );
  }
}

// class RestaurantCategories {
//   List<FoodCategory>? food;
//   List<DrinkCategory>? drink;
//   List<OtherCategory>? other;
//   RestaurantCategories({
//     this.food,
//     this.drink,
//     this.other,
//   });
// }
