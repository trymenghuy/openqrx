import 'package:openqrx/app/constants/svg.dart';
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:openqrx/domain/enum/lend_reason.dart';
import 'package:openqrx/domain/model/input_rule.dart';
import 'package:openqrx/helper/service/input_service.dart';

class LendInput {
  String? id;
  String? uid;
  String? title;
  double? value;
  LendInput({this.id, this.uid, this.title, this.value});
  static InputRule input = InputRule(
      id: 'lend',
      description: 'Get money first then pay later',
      icons: {
        'uid': SvgIcons.xUserBlockBoldDuotone,
        'title': SvgIcons.xNotebookBoldDuotone,
        'value': SvgIcons.xDollarBoldDuotone
      },
      map: LendInput.fromJson({}).toJson(),
      digits: ['value'],
      option: {'title': LendReason.values.map((e) => ItemBase.fromEnum(e))},
      dynamicOption: {
        'uid': InputService().getWorkers,
      });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'value': value,
      'title': title,
    };
  }

  factory LendInput.fromJson(Map<String, dynamic> map) {
    return LendInput(
      id: map['id'] != null ? map['id'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      value: map['value'] != null ? map['value'] as double : null,
      title: map['title'] != null ? map['title'] as String : null,
    );
  }
}
