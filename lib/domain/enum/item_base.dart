// ignore_for_file: public_member_api_docs, sort_constructors_first

abstract class OptBase {
  dynamic get value;
  String? get en;
  String? get km;
  String get title;
}

abstract class Identifiable {
  String get id;
}

class ItemBase {
  final dynamic value;
  final num? worth;
  final String title;
  final String? unit;
  final String? subtitle;
  final String? imageUrl;
  ItemBase({
    required this.value,
    required this.title,
    this.unit,
    this.worth,
    this.subtitle,
    this.imageUrl,
  });
  factory ItemBase.fromEnum(OptBase e) =>
      ItemBase(value: e.value, title: e.title);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'value': value,
      'title': title,
      'unit': unit,
      'subtitle': subtitle,
      'worth': worth,
      'imageUrl': imageUrl,
    };
  }

  factory ItemBase.fromJson(Map<String, dynamic> map) {
    return ItemBase(
      value: map['value'] as dynamic,
      title: map['title'] as String,
      unit: map['unit'] != null ? map['unit'] as String : null,
      subtitle: map['subtitle'] != null ? map['subtitle'] as String : null,
      worth: map['worth'] != null ? map['worth'] as num : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
    );
  }
}
