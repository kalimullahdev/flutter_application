import 'package:flutter/material.dart';
import 'package:flutter_application/page_animations/fade_route.dart';
import 'package:flutter_application/presentation/auth/login/login_page.dart';
import 'package:flutter_application/presentation/navigations/app_drawer/app_drawer.dart';
import 'package:flutter_application/presentation/navigations/custom_tab_bar/custom_tab_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  // ignore: prefer_final_fields
  static List<Widget> _widgetOptions = <Widget>[
    const CustomTabBar(),
    ProfilePage(),
    const SettingsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavBarButtonsList(
      widgetOptions: _widgetOptions,
      onItemTapped: _onItemTapped,
      selectedIndex: _selectedIndex,
    );
  }
}

class BottomNavBarButtonsList extends ConsumerWidget {
  const BottomNavBarButtonsList({
    Key? key,
    required this.widgetOptions,
    required this.onItemTapped,
    required this.selectedIndex,
  }) : super(key: key);

  final List<Widget> widgetOptions;
  final void Function(int index) onItemTapped;
  final int selectedIndex;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: <AppBar>[
        AppBar(
          elevation: 0,
          title: const Text("Home"),
          actions: [
            IconButton(
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Row(
                      children: const [
                        Icon(Icons.logout),
                        SizedBox(width: 8),
                        Text('Logout'),
                      ],
                    ),
                    content: const Text('Are you sure you want to Logout?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'No'),
                        child: const Text('No'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pushAndRemoveUntil(
                          context,
                          FadeRoute(
                            page: LoginPage(),
                          ),
                          (route) => false,
                        ),
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.logout),
            )
          ],
        ),
        AppBar(
          title: const Text("Profile"),
        ),
        AppBar(
          title: const Text("Settings"),
        )
      ].elementAt(selectedIndex),
      drawer: AppDrawer(
        activeTileName: "home",
      ),
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: const Color(0xff019589),
        onTap: onItemTapped,
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Profile Page'),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isThemeSwtich = false;

  void themeSwitch() {
    if (isThemeSwtich == false) {
      setState(() {
        isThemeSwtich = true;
      });
    } else {
      setState(() {
        isThemeSwtich = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListTile(
        title: Text(
          "Change Theme",
          style: Theme.of(context).textTheme.bodyText1,
        ),
        trailing: Switch(
          onChanged: (value) => themeSwitch(),
          value: isThemeSwtich,
          activeColor: Colors.blue,
          activeTrackColor: Colors.grey[400],
          inactiveThumbColor: Colors.grey[600],
          inactiveTrackColor: Colors.grey[400],
        ),
      ),
    );
  }
}
