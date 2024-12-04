import 'package:flutter/material.dart';
import 'package:openqrx/domain/model/feed/feed_input.dart';
import 'package:openqrx/domain/model/map_form.dart';
import 'package:openqrx/feature/shared/generic/generic_form.dart';

class FeedForm extends MapForm {
  const FeedForm({super.key, super.map});

  @override
  Widget build(BuildContext context) {
    return GenericForm(
      appBar: AppBar(
        title: const Text('Feed'),
      ),
      input: FeedInput.input,
      map: map,
    );
  }
}
