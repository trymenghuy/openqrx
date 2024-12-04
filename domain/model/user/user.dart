// ignore_for_file: public_member_api_docs, sort_constructors_first

class User {
  final String id;
  final String name;
  final String? imageUrl;
  User({
    required this.id,
    required this.name,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
    };
  }

  factory User.fromJson(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
    );
  }
}
