import 'package:flutter/material.dart';
import 'package:openqrx/domain/model/map_form.dart';
import 'package:openqrx/domain/model/worker/worker_input.dart';
import 'package:openqrx/feature/shared/generic/generic_form.dart';

class WorkerForm extends MapForm {
  const WorkerForm({super.key, super.map});

  @override
  Widget build(BuildContext context) {
    return GenericForm(
      appBar: AppBar(
        title: const Hero(tag: 'homeWorker', child: Text('Worker')),
      ),
      input: WorkerInput.input,
      map: map,
    );
  }
}
