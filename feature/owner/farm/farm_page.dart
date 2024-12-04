import 'package:flutter/material.dart';
import 'package:openqrx/app/util/navigator.dart';
import 'package:openqrx/app/util/route.dart';
import 'package:openqrx/domain/model/farm/farm.dart';
import 'package:openqrx/feature/owner/farm/farm_form.dart';
import 'package:openqrx/feature/shared/generic/generic_page.dart';
import 'package:openqrx/feature/shared/widgets/pop_icon_item.dart';
import 'package:share_plus/share_plus.dart';

class FarmPage extends StatelessWidget {
  const FarmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericPage<Farm>(
        collection: 'Farm',
        form: (map) => FarmForm(map: map),
        fromJson: Farm.fromJson,
        toJson: (data) => data.toJson(),
        fieldMap: 'member',
        farmLevel: false,
        itemBuilder: (e, editButton, deleteButton) {
          return Card(
            child: ListTile(
              title: Text(e.title),
              // leading: ,
              subtitle: Text(e.member.toString()),
              trailing: PopupMenuButton(
                itemBuilder: (_) {
                  return [
                    PopIconItem(
                      icon: Icons.share,
                      text: 'Share Link',
                      onTap: () {
                        final uri = Uri.parse(
                            'https://tmh-pos.web.app/shop/${e.username}');
                        Share.shareUri(uri);
                      },
                    ),
                    PopIconItem(
                      icon: Icons.qr_code,
                      text: 'QR Code',
                      onTap: () {
                        XNavigator.pushName(AppRoutes.farmQr, arguments: e);
                      },
                    ),
                    editButton(e),
                    deleteButton(e)
                  ];
                },
              ),
            ),
          );
        });
  }
}
