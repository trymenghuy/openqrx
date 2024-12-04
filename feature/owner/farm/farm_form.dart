import 'package:flutter/material.dart';
import 'package:openqrx/domain/model/farm/farm_input.dart';
import 'package:openqrx/domain/model/map_form.dart';
import 'package:openqrx/feature/shared/generic/generic_form.dart';

class FarmForm extends MapForm {
  const FarmForm({super.key, super.map});

  @override
  Widget build(BuildContext context) {
    return GenericForm(
      appBar: AppBar(
        title: const Text('Farm'),
      ),
      input: FarmInput.input,
      map: map,
      farmLevel: false,
      // onSubmit: (map) {
      //   Navigator.of(context).pop(map);
      // },
    );
  }
}
