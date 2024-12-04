// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:openqrx/domain/enum/e_category.dart';
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:openqrx/domain/model/input_rule.dart';

class ProductInput {
  String? id;
  String? kh;
  String? en;
  num? price;
  String? imageUrl;
  List<String>? category;

  ProductInput(
      {this.id, this.kh, this.en, this.price, this.imageUrl, this.category});
  static InputRule input = InputRule(
      id: 'product',
      map: ProductInput.fromJson({}).toJson(),
      optionals: ['en', 'imageUrl'],
      option: {'category': ECategory.values.map((e) => ItemBase.fromEnum(e))},
      multiOptions: ['category'],
      digits: ['price'],
      files: ['imageUrl']);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
      'id': id,
      'kh': kh,
      'price': price,
      'en': en,
      'category': category,
    };
  }

  factory ProductInput.fromJson(Map<String, dynamic> map) {
    return ProductInput(
      id: map['id'] != null ? map['id'] as String : null,
      kh: map['kh'] != null ? map['kh'] as String : null,
      en: map['en'] != null ? map['en'] as String : null,
      price: map['price'] != null ? map['price'] as num : null,
      category:
          map['category'] != null ? map['category'] as List<String> : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
    );
  }
}
