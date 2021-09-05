import 'package:flutter/material.dart';
import 'package:flutter_application/presentation/navigations/app_drawer/app_drawer.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        activeTileName: "about",
      ),
      appBar: AppBar(
        title: const Text('About Page'),
      ),
      body: const Center(
        child: Text('About Page'),
      ),
    );
  }
}
