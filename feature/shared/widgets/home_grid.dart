import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';

class HomeGrid extends StatelessWidget {
  final List<Widget> children;
  const HomeGrid({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: x10,
      crossAxisSpacing: x10,
      childAspectRatio: 1.05,
      padding: const EdgeInsets.all(x10),
      children: children,
    );
  }
}
