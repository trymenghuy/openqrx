import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/domain/model/product/product.dart';
import 'package:openqrx/feature/shared/generic/generic_page.dart';
import 'package:openqrx/feature/shared/product/product_form.dart';
import 'package:openqrx/helper/img_helper.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GenericPage<Product>(
      collection: 'Product',
      form: (map) => ProductForm(map: map),
      isTotal: true,
      fromJson: Product.fromJson,
      toJson: (data) => data.toJson(),
      divider: const Divider(),
      itemBuilder: (e, editButton, _) => ListTile(
        leading: ImgHelper.avatar(e.imageUrl),
        title: Text(
          e.title,
          style: xStyle.titleMedium,
        ),
        subtitle: Text(
          e.price.toRiel,
          style: xGreyStyleLarge,
        ),
        trailing: PopupMenuButton(
          itemBuilder: (context) {
            return [editButton(e, title: e.title)];
          },
        ),
      ),
    );
  }
}
