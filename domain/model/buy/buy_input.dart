import 'package:openqrx/app/constants/svg.dart';
import 'package:openqrx/domain/model/input_rule.dart';
import 'package:openqrx/feature/shared/generic/widgets/product_operator.dart';
import 'package:openqrx/helper/service/input_service.dart';

class BuyInput {
  String? id;
  String? uid;
  String? note;
  Map<String, dynamic>? product;
  BuyInput({this.id, this.uid, this.note, this.product});
  static InputRule input = InputRule(
      id: 'buy',
      description: 'Worker can buy things first then pay later',
      icons: {
        'uid': SvgIcons.xUserBlockBoldDuotone,
        'note': SvgIcons.xNotebookBoldDuotone,
        'product': SvgIcons.xCart3BoldDuotone
      },
      map: BuyInput.fromJson({}).toJson(),
      nestedOptions: {
        'product': (item, provider, entry) =>
            ProductOperator(item, provider, entry),
      },
      dynamicOption: {
        'uid': InputService().getWorkers,
        'product': InputService().getProducts,
      },
      multiOptions: ['product'],
      skips: ['note'],
      optionals: ['note']);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'uid': uid,
      'product': product,
      'note': note,
    };
  }

  factory BuyInput.fromJson(Map<String, dynamic> map) {
    return BuyInput(
      id: map['id'] != null ? map['id'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
      product: map['product'] != null
          ? map['product'] as Map<String, dynamic>
          : null,
      note: map['note'] != null ? map['note'] as String : null,
    );
  }
}
