import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';

class EmptyAppState extends StatelessWidget {
  const EmptyAppState({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(
          Icons.hourglass_empty,
          size: x50,
        ),
      ),
    );
  }
}
