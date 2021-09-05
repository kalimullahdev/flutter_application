import 'package:flutter/material.dart';
import 'package:flutter_application/presentation/navigations/app_drawer/app_drawer.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        activeTileName: "history",
      ),
      appBar: AppBar(
        title: const Text('History Page'),
      ),
      body: const Center(
        child: Text('History Page'),
      ),
    );
  }
}
