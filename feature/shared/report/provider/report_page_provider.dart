import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/provider/user_provider.dart';
import 'package:openqrx/app/service/date_service.dart';
import 'package:openqrx/app/util/app_state.dart';
import 'package:openqrx/domain/model/product/product.dart';
import 'package:openqrx/domain/model/report/daily_report.dart';
import 'package:openqrx/helper/service/store_service.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ReportPageProvider with ChangeNotifier {
  AppState<List<DailyReport>> _widget = const AppState();
  AppState<List<DailyReport>> get widget => _widget;
  void _setState(AppState<List<DailyReport>> state) {
    _widget = state;
    notifyListeners();
  }

  String _range = DateFormat('dd/MM/yyyy').format(DateTime.now());
  String get range => _range;
  List<DateTime> _selectedDates = [DateTime.now()];
  List<DateTime> get selectedDates => _selectedDates;
  void onDateChanged(PickerDateRange value) {
    final startDate = value.startDate;
    final endDate = value.endDate;
    if (startDate != null) {
      final startFormatted = DateFormat('dd/MM/yyyy').format(startDate);
      if (endDate != null) {
        _range =
            '$startFormatted - ${DateFormat('dd/MM/yyyy').format(endDate)}';
        _selectedDates = _generateDateList(startDate, endDate);
      } else {
        _range = startFormatted;
        _selectedDates = [startDate];
      }
    } else {
      _range = '';
      _selectedDates = [];
    }
    _setState(_widget.init(null));
    get();
  }

  List<DateTime> _generateDateList(DateTime start, DateTime end) {
    List<DateTime> dates = [];
    for (var date = start;
        date.isBefore(end.add(const Duration(days: 1)));
        date = date.add(const Duration(days: 1))) {
      dates.add(date);
    }
    return dates;
  }

  Map<String, Product> product = {};

  Future<void> getProduct() async {
    final farmId = UserProvider.instance.defaultFarm;
    final doc = await StoreService.instance
        .collection('Farm/$farmId/Total')
        .doc('product')
        .get();
    final data = doc.data();
    if (data != null) {
      product = data.map((key, value) => MapEntry(
          key, Product.fromJson(Map<String, dynamic>.from(value).setId(key))));
    }
  }

  void get() async {
    final dayIds =
        _selectedDates.map((e) => DateService.instance.dayId(e)).toSet();
    if (dayIds.isEmpty) {
      return;
    }
    final farmId = UserProvider.instance.defaultFarm;
    if (product.isEmpty) {
      await getProduct();
    }
    final docs = await StoreService.instance
        .collection('Farm/$farmId/Metric/Order/Day')
        .where(FieldPath.documentId, whereIn: dayIds)
        .get();
    if (docs.size == 0) {
      return _setState(_widget.empty());
    }
    List<DailyReport> list = [];
    for (final e in docs.docs) {
      if (e.exists) {
        list.insert(0, mapToReport(e.id, e.data()));
      }
    }
    _setState(_widget.set(list));
  }
  // void get() async {
  //   final dayId = DateService.instance.dayId(toDay);
  //   final farmId = UserProvider.instance.defaultFarm;
  //   if (product.isEmpty) {
  //     await getProduct();
  //   }
  //   final doc = await StoreService.instance
  //       .collection('Farm/$farmId/Metric/Order/Day')
  //       .doc(dayId)
  //       .get();
  //   xPrint(doc.data());
  //   if (!doc.exists) {
  //     return _setState(_widget.empty());
  //   }
  //   Map<String, int> productCount = {};
  //   int total = 0;
  //   for (var data in doc.data()!.values) {
  //     final products = data['product'] as Map<String, dynamic>;
  //     for (final e in products.entries) {
  //       if (!productCount.containsKey(e.key)) {
  //         productCount[e.key] = 0;
  //       }
  //       productCount[e.key] = productCount[e.key]! + (e.value as int);
  //     }
  //     total += data['total'] as int;
  //   }
  //   _setState(_widget.set(DailyReport(product: productCount, total: total)));
  // }

  DailyReport mapToReport(String dayId, Map<String, dynamic> oneDayData) {
    Map<String, int> productCount = {};
    int total = 0;
    for (var data in oneDayData.values) {
      final products = data['product'] as Map<String, dynamic>;
      for (final e in products.entries) {
        if (!productCount.containsKey(e.key)) {
          productCount[e.key] = 0;
        }
        productCount[e.key] = productCount[e.key]! + (e.value as int);
      }
      total += data['total'] as int;
    }
    return DailyReport(dayId: dayId, product: productCount, total: total);
  }
}
