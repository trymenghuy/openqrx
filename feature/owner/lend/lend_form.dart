import 'package:flutter/material.dart';
import 'package:openqrx/domain/model/lend/lend_input.dart';
import 'package:openqrx/domain/model/map_form.dart';
import 'package:openqrx/feature/shared/generic/generic_form.dart';

class LendForm extends MapForm {
  const LendForm({super.key, super.map});

  @override
  Widget build(BuildContext context) {
    return GenericForm(
      appBar: AppBar(
        title: const Text('Lend'),
      ),
      input: LendInput.input,
    );
  }
}
