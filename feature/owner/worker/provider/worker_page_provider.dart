// import 'package:flutter/material.dart';
// import 'package:openqrx/app/extensions/data_extensions.dart';
// import 'package:openqrx/app/util/app_state.dart';
// import 'package:openqrx/domain/model/worker/worker.dart';
// import 'package:openqrx/helper/service/store_service.dart';

// class WorkerPageProvider with ChangeNotifier {
//   AppState<Iterable<Worker>> _widget = const AppState();
//   AppState<Iterable<Worker>> get widget => _widget;
//   void _setState(AppState<Iterable<Worker>> state) {
//     _widget = state;
//     notifyListeners();
//   }

//   void get() async {
//     final doc =
//         await StoreService.instance.collection('Total').doc('worker').get();
//     final data = doc.data();
//     if (data != null) {
//       final list = data.entries.map(
//         (e) => Worker.fromJson(Map<String, dynamic>.from(e.value).setId(e.key)),
//       );
//       _setState(
//           _widget.set(list.sortedBy((e) => e.position.index, desc: false)));
//     }
//   }
// }
