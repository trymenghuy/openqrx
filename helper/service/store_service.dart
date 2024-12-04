import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:openqrx/flavors.dart';

class StoreService {
  static StoreService? _instance;
  StoreService._();
  static StoreService get instance {
    _instance ??= StoreService._();
    return _instance!;
  }

  // static Map<String, dynamic> clean(Map<String, dynamic> map) {
  //   final newMap = Map<String, dynamic>.from(map);
  //   return newMap.clean();
  // }

  FirebaseFirestore getDb = FirebaseFirestore.instanceFor(
      app: FirebaseFirestore.instance.app, databaseId: F.db);
  CollectionReference<Map<String, dynamic>> collection(String collection) =>
      getDb.collection(collection);
  DocumentReference<Map<String, dynamic>> doc(
          String collection, String? docId) =>
      getDb.collection(collection).doc(docId);

  Query<Map<String, dynamic>> query(String path,
      {int limit = 10, DocumentSnapshot? before, order = true}) {
    Query<Map<String, dynamic>> query = collection(path);
    if (order) {
      query = query.orderBy('createdAt', descending: true);
    }
    if (before != null) {
      query = query.startAfterDocument(before);
    }
    return query.limit(limit);
  }
}
