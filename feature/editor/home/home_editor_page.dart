import 'package:flutter/material.dart';
import 'package:openqrx/app/util/txt.dart';
import 'package:openqrx/feature/owner/home/widgets/drawer_tile.dart';
import 'package:openqrx/feature/owner/home/widgets/home_base_drawer.dart';

class HomeEditorPage extends StatelessWidget {
  const HomeEditorPage({super.key});
  Widget _tab({required String label, required IconData icon}) {
    return Card(
      margin: EdgeInsets.zero,
      child: Tab(
        height: 70,
        iconMargin: const EdgeInsets.only(bottom: x5),
        icon: Icon(
          icon,
          size: x30,
        ),
        child: Text(
          label,
          style: xStyle.labelMedium,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: HomeBaseDrawer(
        children: [
          DrawerTile(
            svg: const Icon(Icons.settings),
            text: 'Setting',
            onTap: () {},
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('Editor'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // XNavigator.pushName(Routes.dailyForm);
        },
        child: const Icon(Icons.add),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: x10,
        crossAxisSpacing: x10,
        childAspectRatio: 1.05,
        padding: const EdgeInsets.all(x10),
        children: [
          _tab(icon: Icons.bar_chart, label: 'Compare'),
          _tab(icon: Icons.table_chart_outlined, label: 'Weekly'),
        ],
      ),
    );
  }
}
