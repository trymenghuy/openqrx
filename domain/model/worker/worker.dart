import 'package:openqrx/domain/enum/e_work_role.dart';
import 'package:openqrx/domain/enum/e_work_tag.dart';
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:openqrx/helper/form/convert_helper.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Worker implements Identifiable {
  @override
  final String id;
  final String name;
  final EWorkRole position;
  final num salary;
  final dynamic phone;
  final DateTime? startedDate;
  final DateTime? endDate;
  final List<EWorkTag> tags;
  final String? note;
  final String? imageUrl;
  Worker({
    required this.id,
    required this.name,
    required this.position,
    required this.salary,
    required this.phone,
    this.startedDate,
    this.endDate,
    required this.tags,
    this.note,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'position': position.value,
      'salary': salary,
      'phone': phone,
      'startedDate': startedDate,
      'endDate': endDate,
      'tags': tags.map((e) => e.value).toList(),
      'note': note,
      'imageUrl': imageUrl,
    };
  }

  factory Worker.fromJson(Map<String, dynamic> map) {
    return Worker(
      id: map['id'] as String,
      name: map['name'] as String,
      position: EWorkRole.from(map['position']),
      salary: map['salary'] as num,
      phone: map['phone'] as dynamic,
      startedDate: ConvertHelper.otherToDate(map['startedDate']),
      endDate: ConvertHelper.otherToDate(map['endDate']),
      tags: List<dynamic>.from((map['tags']))
          .map((e) => EWorkTag.from(e))
          .toList(),
      note: map['note'] != null ? map['note'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
    );
  }
}
