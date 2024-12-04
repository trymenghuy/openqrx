import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/provider/user_provider.dart';
import 'package:openqrx/app/util/app_state.dart';
import 'package:openqrx/app/util/print.dart';
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:openqrx/domain/model/doc_offset.dart';
import 'package:openqrx/domain/model/map_form.dart';
import 'package:openqrx/feature/shared/generic/abstract/generic_page_abstract.dart';
import 'package:openqrx/helper/service/store_service.dart';
import 'package:openqrx/helper/toast_helper.dart';

class GenericPageProvider<T extends Identifiable>
    with ChangeNotifier
    implements GenericPageAbstract<T> {
  final String collection;
  final String? fieldEqual;
  final String? fieldMap;
  final bool isTotal;
  final T Function(Map<String, dynamic>) fromJson;
  final Map<String, dynamic> Function(T) toJson;
  final Iterable<T> Function(Iterable<T>)? sortedBy;
  final FormBuilder? form;
  final bool farmLevel;
  bool _isDisposed = false;
  GenericPageProvider(this.collection, this.isTotal, this.fromJson, this.toJson,
      this.sortedBy, this.form, this.farmLevel, this.fieldEqual, this.fieldMap);
  AppState<List<T>> _widget = AppState<List<T>>();
  AppState<List<T>> get widget => _widget;
  void _setState(AppState<List<T>> state) {
    if (_isDisposed) return;
    _widget = state;
    notifyListeners();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  @override
  DocOffset offset = DocOffset(limit: 5);
  @override
  void add(T data) async {
    final old = _widget.data.orEmpty;
    final index = old.indexWhere((e) => e.id == data.id);
    if (index >= 0) {
      old[index] = data;
    } else {
      old.insert(0, data);
    }
    _setState(_widget.set(old));
  }

  @override
  void remove(T data) async {
    await StoreService.instance.collection('Delete').doc(data.id).delete();
    Toast.pop('Buy deleted successfully');
    final old = _widget.data.orEmpty;
    _setState(_widget.set(old..remove(data)));
  }

  @override
  void get({bool more = false}) async {
    try {
      if (offset.fetch || !offset.hasMore) return;
      offset.fetch = true;
      final old = _widget.data.orEmpty;
      Iterable<T> list = [];
      final prefix =
          farmLevel ? 'Farm/${UserProvider.instance.defaultFarm}/' : '';
      if (isTotal) {
        final doc = await StoreService.instance
            .collection('${prefix}Total')
            .doc(collection.toLowerCase())
            .get();
        final data = doc.data();
        if (data != null) {
          list = data.entries.map((e) =>
              fromJson((Map<String, dynamic>.from(e.value).setId(e.key))));
        }
        xPrint('total ${list.length}');
        offset.hasMore = false;
      } else {
        Query<Map<String, dynamic>> query = StoreService.instance.query(
            prefix + collection,
            before: offset.before,
            limit: offset.limit,
            order: fieldEqual == null && fieldMap == null);
        final uid = UserProvider.instance.uid;
        if (fieldEqual != null) {
          query = query.where(fieldEqual!, isEqualTo: uid);
        } else if (fieldMap != null) {
          query = query.where('$fieldMap.$uid', isNull: false);
        }
        final docs = await query.get();
        list = docs.docs.map((e) => fromJson(e.data().setId(e.id)));
        if (docs.size > 0) offset.before = docs.docs.last;
        offset.fetch = false;
        offset.hasMore = docs.size == offset.limit;
        xPrint('docs ${docs.size}');
      }
      if (sortedBy != null) {
        list = sortedBy!(list);
      }
      _setState(_widget.set(old..addAll(list)));
    } catch (e, stackTrace) {
      xPrint(stackTrace, error: true);
      xPrint('$e $collection', error: true);
      Toast.pop('$e $collection', error: true);
    }
  }
}
