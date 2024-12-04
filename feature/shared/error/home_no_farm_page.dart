import 'package:flutter/material.dart';
import 'package:openqrx/app/util/navigator.dart';
import 'package:openqrx/app/util/route.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/feature/owner/home/widgets/home_base_drawer.dart';

class HomeNoFarmPage extends StatelessWidget {
  final bool isFarm;
  const HomeNoFarmPage({super.key, this.isFarm = false});

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
              padding: const EdgeInsets.all(x15),
              child: FilledButton.icon(
                onPressed: () {
                  XNavigator.pushName(AppRoutes.farm);
                },
                icon: const Icon(Icons.add),
                label: const Text(
                  'Create farm',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
