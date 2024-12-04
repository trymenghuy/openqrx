import 'package:flutter/material.dart';

typedef FormBuilder = Widget Function(Map<String, dynamic>? map);

abstract class MapForm extends StatelessWidget {
  final Map<String, dynamic>? map;

  const MapForm({super.key, this.map});

  @override
  Widget build(BuildContext context);
}
