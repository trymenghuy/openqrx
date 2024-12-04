import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/service/date_service.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/enum/item_base.dart';
import 'package:openqrx/domain/model/lend/lend.dart';
import 'package:openqrx/feature/owner/lend/lend_form.dart';
import 'package:openqrx/feature/shared/generic/generic_page.dart';

class LendPage extends StatelessWidget {
  const LendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericPage<Lend>(
        collection: 'Lend',
        form: (map) => LendForm(map: map),
        fromJson: Lend.fromJson,
        toJson: (data) => data.toJson(),
        itemBuilder: (e, editButton, deleteButton) {
          ItemBase? profile;
          if (e.other?['uid'] != null) {
            profile = ItemBase.fromJson(e.other?['uid']);
          }
          return Card(
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            profile?.title ?? e.uid,
                            style: xStyle.titleMedium,
                          ),
                          Text(
                            DateService.instance.fullText(e.createdAt),
                            style: xGreyStyleMedium,
                          ),
                        ],
                      ),
                      space10,
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          e.value.toRiel,
                          style:
                              xStyle.titleMedium?.copyWith(color: xColor.error),
                        ),
                      )
                    ],
                  ),
                ),
                PopupMenuButton(itemBuilder: (_) {
                  return [deleteButton(e, title: profile?.title)];
                }),
              ],
            ),
          );
        });
  }
}
