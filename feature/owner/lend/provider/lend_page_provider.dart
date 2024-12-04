import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/util/app_state.dart';
import 'package:openqrx/app/util/print.dart';
import 'package:openqrx/domain/model/doc_offset.dart';
import 'package:openqrx/domain/model/lend/lend.dart';
import 'package:openqrx/helper/service/store_service.dart';
import 'package:openqrx/helper/toast_helper.dart';

class LendPageProvider with ChangeNotifier {
  AppState<List<Lend>> _widget = const AppState();
  AppState<List<Lend>> get widget => _widget;
  void _setState(AppState<List<Lend>> state) {
    _widget = state;
    notifyListeners();
  }

  void add(Lend lend) {
    final old = _widget.data.orEmpty;
    _setState(_widget.set(old..insert(0, lend)));
  }

  void remove(Lend lend) async {
    await StoreService.instance.collection('Lend').doc(lend.id).delete();
    Toast.pop('Lend deleted successfully');
    final old = _widget.data.orEmpty;
    _setState(_widget.set(old..remove(lend)));
  }

  DocOffset offset = DocOffset(limit: 5);
  void get({bool more = false}) async {
    if (offset.fetch || !offset.hasMore) return;
    offset.fetch = true;
    final docs = await StoreService.instance
        .query('Lend', before: offset.before, limit: offset.limit)
        .get();
    final old = _widget.data.orEmpty;
    final list =
        docs.docs.map((e) => Lend.fromJson(e.data().setId(e.id))).toList();
    if (docs.size > 0) offset.before = docs.docs.last;
    offset.fetch = false;
    offset.hasMore = docs.size == offset.limit;
    xPrint('docs ${docs.size}');
    _setState(_widget.set(old..addAll(list)));
  }
}
