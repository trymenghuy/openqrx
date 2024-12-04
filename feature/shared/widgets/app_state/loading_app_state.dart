import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';

class LoadingAppState extends StatelessWidget {
  const LoadingAppState({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: xColor.onSurface.withOpacity(0.2),
        alignment: Alignment.center,
        child: button.loading());
  }
}
