import 'package:flutter/material.dart';
import 'package:openqrx/domain/model/map_form.dart';
import 'package:openqrx/domain/model/shop/shop_input.dart';
import 'package:openqrx/feature/shared/generic/generic_form.dart';

class ProductForm extends MapForm {
  const ProductForm({super.key, super.map});

  @override
  Widget build(BuildContext context) {
    return GenericForm(
      appBar: AppBar(
        title: const Text('Shop'),
      ),
      input: ShopInput.input,
      map: map,
    );
  }
}
