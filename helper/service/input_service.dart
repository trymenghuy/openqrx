// import 'package:openqrx/app/extensions/data_extensions.dart';
// import 'package:openqrx/domain/enum/item_base.dart';
// import 'package:openqrx/domain/model/feed/feed.dart';
// import 'package:openqrx/domain/model/worker/worker.dart';
// import 'package:openqrx/helper/service/store_service.dart';

// class InputService {
//   Future<List<ItemBase>> getWorkers() async {
//     List<ItemBase> list = [];
//     final doc =
//         await StoreService.instance.collection('Total').doc('worker').get();
//     final data = doc.data();
//     if (data != null) {
//       final workers = data.entries.map(
//         (e) => Worker.fromJson(Map<String, dynamic>.from(e.value).setId(e.key)),
//       );
//       for (final e in workers.sortedBy((e) => e.position.index, desc: false)) {
//         list.add(ItemBase(title: e.name, value: e.id, subtitle: '${e.phone}'));
//       }
//     }
//     return list;
//   }

//   Future<List<ItemBase>> getFeeds() async {
//     List<ItemBase> list = [];
//     final doc =
//         await StoreService.instance.collection('Total').doc('feed').get();
//     final data = doc.data();
//     if (data != null) {
//       final workers = data.entries.map(
//         (e) => Feed.fromJson(Map<String, dynamic>.from(e.value).setId(e.key)),
//       );
//       for (final e in workers.sortedBy((e) => e.week.index, desc: false)) {
//         list.add(ItemBase(title: e.title, value: e.id, subtitle: '${e.week}'));
//       }
//     }
//     return list;
//   }
// }
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/provider/user_provider.dart';
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:openqrx/domain/model/feed/feed.dart';
import 'package:openqrx/domain/model/product/product.dart';
import 'package:openqrx/domain/model/user/user.dart';
import 'package:openqrx/domain/model/worker/worker.dart';
import 'package:openqrx/helper/service/store_service.dart';

class InputService {
  Future<List<ItemBase>> _getItems<T>({
    required String collectionName,
    required T Function(Map<String, dynamic>) fromJson,
    required ItemBase Function(T) getItem,
    Comparable Function(T)? sortBy,
    bool descending = false,
    bool farmLevel = true,
  }) async {
    List<ItemBase> list = [];
    String cll = 'Total';
    if (farmLevel) {
      cll = 'Farm/${UserProvider.instance.defaultFarm}/Total';
    }
    final doc =
        await StoreService.instance.collection(cll).doc(collectionName).get();
    final data = doc.data();
    if (data != null) {
      var items = data.entries.map(
        (e) => fromJson(Map<String, dynamic>.from(e.value).setId(e.key)),
      );
      if (sortBy != null) {
        items = items.sortedBy(sortBy, desc: descending);
      }
      for (final e in items) {
        list.add(getItem(e));
      }
    }
    return list;
  }

  Future<List<ItemBase>> getWorkers() async {
    return _getItems<Worker>(
      collectionName: 'worker',
      fromJson: Worker.fromJson,
      getItem: (e) => ItemBase(
          value: e.id,
          title: e.name,
          subtitle: '${e.phone}',
          imageUrl: e.imageUrl),
      sortBy: (e) => e.position.index,
    );
  }

  Future<List<ItemBase>> getUsers() async {
    return _getItems<User>(
      collectionName: 'user',
      fromJson: User.fromJson,
      farmLevel: false,
      getItem: (e) =>
          ItemBase(value: e.id, title: e.name, imageUrl: e.imageUrl),
    );
  }

  Future<(List<ItemBase>, List<ItemBase>)> getPens() async {
    final farmId = UserProvider.instance.defaultFarm;
    List<ItemBase> list = [];
    final doc =
        await StoreService.instance.collection('Farm').doc(farmId).get();
    if (doc.exists) {
      final data = Map<String, dynamic>.from(doc.data()?['pigsty'] ?? {});
      if (data.isNotEmpty) {
        for (final e in data.entries) {
          list.add(ItemBase(value: e.key, title: e.value['value']));
        }
      }
    }
    final feeds = await getFeeds();
    return (list, feeds);
  }

  Future<List<ItemBase>> getFeeds() async {
    return _getItems<Feed>(
      collectionName: 'feed',
      fromJson: Feed.fromJson,
      getItem: (e) => ItemBase(
          value: e.id,
          worth: e.net.value,
          title: e.title,
          unit: 'Kg',
          subtitle: e.net.title),
      sortBy: (e) => e.week.index,
    );
  }

  Future<List<ItemBase>> getProducts() async {
    return _getItems<Product>(
      collectionName: 'product',
      fromJson: Product.fromJson,
      getItem: (e) => ItemBase(
          value: e.id,
          worth: e.price,
          unit: '៛',
          title: e.title,
          subtitle: e.price.toRiel),
      sortBy: (e) => e.price,
    );
  }
}
