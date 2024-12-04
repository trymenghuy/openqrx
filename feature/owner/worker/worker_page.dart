import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/model/worker/worker.dart';
import 'package:openqrx/feature/owner/worker/worker_form.dart';
import 'package:openqrx/feature/shared/generic/generic_page.dart';
import 'package:openqrx/helper/form/format_helper.dart';
import 'package:openqrx/helper/img_helper.dart';

class WorkerPage extends StatelessWidget {
  const WorkerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericPage<Worker>(
        collection: 'Worker',
        isTotal: true,
        form: (map) => WorkerForm(map: map),
        fromJson: Worker.fromJson,
        toJson: (data) => data.toJson(),
        sortedBy: (list) => list.sortedBy((e) => e.position.index, desc: false),
        itemBuilder: (e, editButton, deleteButton) {
          return ListTile(
            contentPadding: const EdgeInsets.only(left: x20),
            leading: ImgHelper.avatar(e.imageUrl),
            title: Text(
              e.name,
              style: xStyle.titleMedium,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(FormatHelper.toPhoneNumber('0${e.phone}'),
                    style: xGreyStyleMedium),
                Text(
                  e.position.title,
                  style: xGreyStyleLarge,
                ),
              ],
            ),
            trailing: PopupMenuButton(
              itemBuilder: (context) {
                return [editButton(e), deleteButton(e)];
              },
            ),
          );
        });
  }
}
