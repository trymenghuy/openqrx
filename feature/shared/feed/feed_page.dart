import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/domain/model/feed/feed.dart';
import 'package:openqrx/feature/shared/feed/feed_form.dart';
import 'package:openqrx/feature/shared/generic/generic_page.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericPage<Feed>(
      collection: 'Feed',
      form: (map) => FeedForm(map: map),
      isTotal: true,
      divider: const Divider(),
      toJson: (data) => data.toJson(),
      fromJson: Feed.fromJson,
      sortedBy: (p0) => p0.sortedBy((e) => e.week.index),
      itemBuilder: (e, editButton, _) => ListTile(
        title: Text(e.title),
        subtitle: Text(e.week.title),
        trailing: PopupMenuButton(
          itemBuilder: (context) {
            return [editButton(e)];
          },
        ),
      ),
    );
  }
}
