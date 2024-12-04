import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/provider/farm_provider.dart';
import 'package:openqrx/app/provider/user_provider.dart';
import 'package:openqrx/app/util/app_state.dart';
import 'package:openqrx/app/util/navigator.dart';
import 'package:openqrx/app/util/print.dart';
import 'package:openqrx/domain/enum/e_category.dart';
import 'package:openqrx/domain/model/farm/farm.dart';
import 'package:openqrx/domain/model/product/product.dart';
import 'package:openqrx/feature/shared/menu/menu_order_page.dart';
import 'package:openqrx/feature/shared/widgets/app_state/loading_app_state.dart';
import 'package:openqrx/helper/service/store_service.dart';
import 'package:openqrx/helper/toast_helper.dart';

class HomeOwnerPageProvider with ChangeNotifier {
  AppState<Iterable<Product>> _widget = const AppState();
  AppState<Iterable<Product>> get widget => _widget;
  void _setState(AppState<Iterable<Product>> state) {
    _widget = state;
    notifyListeners();
  }

  Set<ECategory> filters = {};
  void onFilterChange(ECategory e, bool isSelected) {
    if (isSelected) {
      filters.remove(e);
    } else {
      filters.add(e);
    }
    notifyListeners();
  }

  void onFilterClear() {
    filters.clear();
    notifyListeners();
  }

  void onOrderClear() {
    order.clear();
    notifyListeners();
  }

  Map<String, int> order = {};
  int getQuantity(String id) {
    return order[id] ?? 0;
  }

  void onChanged(String key, int value) {
    if (!order.containsKey(key)) {
      order[key] = 0;
    }
    order[key] = order[key]! + value;
    notifyListeners();
  }

  void onSend() {
    List<Product> products = [];
    for (final e in widget.data!) {
      final qty = getQuantity(e.id);
      if (qty > 0) {
        products.add(e.copyWith(qty: qty));
      }
    }
    DraggableScrollableController controller = DraggableScrollableController();
    showModalBottomSheet(
      context: XNavigator.context,
      isScrollControlled: true,
      // showDragHandle: true,
      useSafeArea: true,
      builder: (context) {
        return DraggableScrollableSheet(
          controller: controller,
          maxChildSize: 1,
          initialChildSize: 0.8,
          expand: false,
          builder: (context, scrollController) {
            return MenuOrderPage(
              products: products,
              controller: scrollController,
              onSend: () async {
                Navigator.pop(context);
                int sumTotal = products.fold(0, (previousValue, element) {
                  return previousValue + (element.qty * element.price).toInt();
                });

                final dayId = DateFormat('dd-MM-yyyy').format(DateTime.now());
                xPrint(dayId);
                final data = {
                  'total': sumTotal,
                  'products': products.map((e) => e.toJson()).toList(),
                  'createdAt': FieldValue.serverTimestamp(),
                  'dayId': dayId,
                };
                _setState(widget.alert(const LoadingAppState()));
                try {
                  final tempId =
                      DateTime.now().millisecondsSinceEpoch.toString();
                  final farmId = UserProvider.instance.defaultFarm;
                  final doc = await StoreService.instance
                      .collection('Farm/$farmId/Order')
                      .add(data);
                  // onPrint();
                  xPrint(doc.id);
                } catch (e) {
                  xPrint(e);
                }
                order.clear();
                _setState(_widget.set(_widget.data));
                Toast.pop('Ordered successfully');
              },
            );
          },
        );
      },
    );
  }

  Farm get farm => FarmProvider.instance.farm!;
  void get() async {
    await FarmProvider.instance.getFarm();
    if (FarmProvider.instance.farm == null) {
      xPrint('_widget.empty');
      _setState(_widget.empty());
    } else {
      final farmId = UserProvider.instance.defaultFarm;
      final doc = await StoreService.instance
          .collection('Farm/$farmId/Total')
          .doc('product')
          .get();
      final data = doc.data();
      if (data != null) {
        final list = data.entries.map((e) =>
            Product.fromJson(Map<String, dynamic>.from(e.value).setId(e.key)));
        _setState(_widget.set(list.sortedBy((e) => e.title, desc: false)));
      } else {
        _setState(_widget.empty());
      }
    }
  }
}
