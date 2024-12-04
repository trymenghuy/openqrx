import 'package:openqrx/domain/model/doc_offset.dart';

abstract class GenericPageAbstract<T> {
  void add(T data);
  // void update(T data);
  void remove(T data);
  DocOffset offset = DocOffset(limit: 5);
  void get({bool more = false});
  // T fromJson(Map<String, dynamic> json);
}
