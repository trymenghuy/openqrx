import 'package:openqrx/domain/model/buy/nested_item.dart';

class ProductHelper {
  static double total(Iterable<NestedItem> list) {
    return list.map((e) => e.getValue * e.getQuality).fold(0, (a, b) => a + b);
  }

  static int totalQuantity(Iterable<NestedItem> list) {
    return list.map((e) => e.getQuality).fold(0, (a, b) => a + b);
  }

  static String totalName(Iterable<NestedItem> list) {
    return list.map((e) => e.title).join(', ');
  }
}
