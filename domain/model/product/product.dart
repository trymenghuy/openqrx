// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:openqrx/app/provider/setting_provider.dart';
import 'package:openqrx/domain/enum/e_category.dart';
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:openqrx/helper/form/convert_helper.dart';

class Product extends Identifiable {
  @override
  final String id;
  final String kh;
  final String? en;
  final num price;
  final String? imageUrl;
  final DateTime? updatedAt;
  final List<ECategory>? category;
  int qty;
  Product({
    required this.id,
    required this.kh,
    this.en,
    required this.price,
    this.imageUrl,
    this.updatedAt,
    this.category,
    this.qty = 0,
  });
  String get title => SettingProvider.instance.isKh ? kh : en ?? kh;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'kh': kh,
      'en': en,
      'price': price,
      'imageUrl': imageUrl,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'category': category?.map((e) => e.name).toList(),
      'qty': qty,
    };
  }

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      kh: map['kh'] as String,
      en: map['en'] != null ? map['en'] as String : null,
      price: map['price'] as num,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      category: map['category'] != null
          ? List.from(map['category'])
              .map((e) => ECategory.fromValue(e))
              .toList()
          : null,
      updatedAt:
          ConvertHelper.otherToDate(map['createdAt'] ?? map['updatedAt']),
      qty: map['qty'] != null ? map['qty'] as int : 0,
    );
  }

  Product copyWith({
    String? id,
    String? kh,
    String? en,
    num? price,
    String? imageUrl,
    DateTime? updatedAt,
    List<ECategory>? category,
    int? qty,
  }) {
    return Product(
      id: id ?? this.id,
      kh: kh ?? this.kh,
      en: en ?? this.en,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      updatedAt: updatedAt ?? this.updatedAt,
      category: category ?? this.category,
      qty: qty ?? this.qty,
    );
  }
}
