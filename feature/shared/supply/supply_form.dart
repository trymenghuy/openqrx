import 'package:flutter/material.dart';
import 'package:openqrx/domain/model/feed/supply_input.dart';
import 'package:openqrx/domain/model/map_form.dart';
import 'package:openqrx/feature/shared/generic/generic_form.dart';

class SupplyForm extends MapForm {
  const SupplyForm({super.key, super.map});

  @override
  Widget build(BuildContext context) {
    return GenericForm(
      appBar: AppBar(
        title: const Text('Supply'),
      ),
      input: SupplyInput.input,
      map: map,
    );
  }
}
