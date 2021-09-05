import 'package:flutter/material.dart';

import 'package:flutter_application/presentation/navigations/app_drawer/app_drawer.dart';
import 'package:flutter_application/presentation/navigations/bottom_nav_bar/bottom_nav_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _activeTileName = 'home';

  void activateListTile(String tileName) {
    setState(() {
      _activeTileName = tileName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        activeTileName: _activeTileName,
        activateListTile: activateListTile,
      ),
      body: const BottomNavBar(),
    );
  }
}
