import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';

class LoadMoreBottom extends StatelessWidget {
  final bool load;
  const LoadMoreBottom({super.key, required this.load});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: load ? button.loading() : const SizedBox(height: 24),
      ),
    );
  }
}
