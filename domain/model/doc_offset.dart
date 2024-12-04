// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class DocOffset {
  DocumentSnapshot? before;
  bool fetch;
  int offset;
  bool hasMore;
  int limit;
  DocOffset(
      {this.before,
      this.fetch = false,
      this.offset = 0,
      this.hasMore = true,
      this.limit = 10});
}
