import 'package:flutter/material.dart';
import 'package:openqrx/domain/model/buy/buy_input.dart';
import 'package:openqrx/domain/model/map_form.dart';
import 'package:openqrx/feature/shared/generic/generic_form.dart';

class BuyForm extends MapForm {
  const BuyForm({super.key, super.map});

  @override
  Widget build(BuildContext context) {
    return GenericForm(
      appBar: AppBar(
        title: const Text('Buy'),
      ),
      input: BuyInput.input,
      map: map,
    );
  }
}
