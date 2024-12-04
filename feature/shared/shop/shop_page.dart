import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/model/shop/shop.dart';
import 'package:openqrx/feature/shared/generic/generic_page.dart';
import 'package:openqrx/feature/shared/product/product_form.dart';
import 'package:openqrx/helper/img_helper.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericPage<Shop>(
      collection: 'Shop',
      form: (map) => ProductForm(map: map),
      fromJson: Shop.fromJson,
      toJson: (data) => data.toJson(),
      farmLevel: false,
      isTotal: false,
      divider: const Divider(),
      itemBuilder: (e, editButton, _) => ListTile(
        leading: ImgHelper.avatar(e.imageUrl),
        title: Text(
          e.name,
          style: xStyle.titleMedium,
        ),
        subtitle: Text(
          e.username,
          style: xGreyStyleLarge,
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) {
            return [editButton(e, title: e.name)];
          },
        ),
      ),
    );
  }
}
