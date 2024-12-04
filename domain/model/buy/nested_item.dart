// ignore_for_file: public_member_api_docs, sort_constructors_first
//TODO need to change add value string for analytics and change worth

class NestedItem {
  final String title;
  final String? unit;
  dynamic value;
  // final num worth;
  int? quantity;

  NestedItem(
      {required this.title,
      // required this.worth,
      this.unit,
      this.quantity,
      this.value});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'unit': unit,
      // 'worth': worth,
      'quantity': quantity,
      'value': value,
    };
  }

  num get getValue => value is String ? 0 : (value ?? 0) as num;
  int get getQuality => (quantity ?? 0);
  bool get isNotValid {
    if (unit != null) {
      return getQuality < 1;
    }
    return value == null || value == '';
  }

  factory NestedItem.fromJson(Map<String, dynamic> map) {
    return NestedItem(
      title: map['title'] as String,
      unit: map['unit'] as String?,
      value: map['value'] ?? map['worth'],
      // worth: map['worth'] ?? map['price'] as num,
      quantity: map['quantity'] as int?,
    );
  }

  NestedItem get zeroValue {
    return NestedItem(
      title: title,
      unit: unit,
      value: null,
      quantity: quantity,
    );
  }
}
