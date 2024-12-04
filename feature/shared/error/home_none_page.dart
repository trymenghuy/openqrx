import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/feature/owner/home/widgets/home_base_drawer.dart';

class HomeNonePage extends StatelessWidget {
  final bool isFarm;
  const HomeNonePage({super.key, this.isFarm = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeBaseDrawer(),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.security,
              size: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: x10),
              child: Text(
                'You don\'t have any ${isFarm ? 'farm' : 'role'} here',
                style: xStyle.titleMedium?.copyWith(color: xColor.error),
              ),
            ),
            const Text('Contact admin for support'),
          ],
        ),
      ),
    );
  }
}
