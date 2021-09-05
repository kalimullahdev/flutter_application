import 'package:flutter/material.dart';
import 'package:flutter_application/presentation/navigations/app_drawer/app_drawer.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        activeTileName: "contactus",
      ),
      appBar: AppBar(
        title: const Text('Contact Us Page'),
      ),
      body: const Center(
        child: Text('Contact Us Page'),
      ),
    );
  }
}
