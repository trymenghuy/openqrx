import 'package:openqrx/app/constants/svg.dart';
import 'package:openqrx/domain/enum/e_work_role.dart';
import 'package:openqrx/domain/enum/e_work_tag.dart';
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:openqrx/domain/model/input_rule.dart';
import 'package:openqrx/helper/form/convert_helper.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class WorkerInput {
  String? id;
  String? name;
  String? position;
  double? salary;
  String? phone;
  DateTime? startedDate;
  DateTime? endDate;
  List<String>? tags;
  String? note;
  String? imageUrl;
  WorkerInput(
      {this.id,
      this.name,
      this.position,
      this.salary,
      this.phone,
      this.startedDate,
      this.endDate,
      this.tags,
      this.note,
      this.imageUrl});
  static InputRule input = InputRule(
      id: 'worker',
      description:
          'A dedicated construction worker with 5+ years of experience in residential and commercial projects',
      skips: ['endDate'],
      digits: ['salary', 'phone'],
      dates: ['startedDate'],
      optionals: ['note', 'imageUrl'],
      multiline: ['note'],
      files: ['imageUrl'],
      icons: {
        'position': SvgIcons.xShieldBoldDuotone,
        'phone': SvgIcons.xPhoneBoldDuotone,
        'startedDate': SvgIcons.xCalendarBoldDuotone,
        'tags': SvgIcons.xTagBoldDuotone,
        'name': SvgIcons.xUserBoldDuotone,
        'salary': SvgIcons.xDollarBoldDuotone,
      },
      map: WorkerInput.fromJson({}).toJson(),
      option: {
        'position': EWorkRole.values.map((e) => ItemBase.fromEnum(e)),
        'tags': EWorkTag.values.map((e) => ItemBase.fromEnum(e))
      },
      multiOptions: ['tags']
      // dynamicOptions: {'position': workRoles},
      );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'position': position,
      'salary': salary,
      'phone': phone,
      'startedDate': ConvertHelper.otherToTimeStamp(startedDate),
      'endDate': ConvertHelper.otherToTimeStamp(endDate),
      'tags': tags,
      'note': note
    };
  }

  factory WorkerInput.fromJson(Map<String, dynamic> map) {
    return WorkerInput(
      id: map['id'] != null ? map['id'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      position: map['position'] != null ? map['position'] as String : null,
      salary: map['salary'] != null ? map['salary'] as double : null,
      phone: map['phone'] != null ? map['phone'] as String : null,
      startedDate: ConvertHelper.otherToDate(map['startedDate']),
      endDate: ConvertHelper.otherToDate(map['endDate']),
      tags: map['tags'] != null
          ? List<String>.from((map['tags'] as List<String>))
          : null,
      note: map['note'] != null ? map['note'] as String : null,
    );
  }
}
