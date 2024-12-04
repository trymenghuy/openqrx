import 'package:flutter/material.dart';
import 'package:openqrx/app/extensions/data_extensions.dart';
import 'package:openqrx/app/util/txt.dart';

class PlaceHolderAppState extends StatelessWidget {
  final String? title;
  const PlaceHolderAppState({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title.orEmpty),
      ),
      body: Center(
        child: button.loading(),
      ),
    );
  }
}
