import 'package:flutter/material.dart';
import 'package:flutter_application/page_animations/scale_route.dart';
import 'package:flutter_application/presentation/about/about_page.dart';
import 'package:flutter_application/presentation/contact_us/contact_us_page.dart';
import 'package:flutter_application/presentation/history/history_page.dart';
import 'package:flutter_application/presentation/home/home_page.dart';
import 'package:flutter_application/presentation/navigations/app_drawer/widgets/custom_list_tile.dart';
import 'package:flutter_application/presentation/users/users_page.dart';

typedef ActivateListTileCallback = Function(String tileName);

// ignore: must_be_immutable
class AppDrawer extends StatefulWidget {
  AppDrawer({
    Key? key,
    required this.activeTileName,
    this.activateListTile,
  }) : super(key: key);

  final String activeTileName;
  ActivateListTileCallback? activateListTile;

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Ink(
        color: const Color(0xff3d3d3d),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SearchBox(),
                ],
              ),
            ),
            CustomListTile(
              iconData: Icons.home,
              title: "Home",
              active: widget.activeTileName == "home",
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => HomePage(),
                  ),
                );
              },
            ),
            CustomListTile(
              iconData: Icons.person,
              active: widget.activeTileName == "chat",
              title: "Users",
              onPressed: () {
                widget.activateListTile != null
                    ? widget.activateListTile!("chat")
                    : null;
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        UsersPage(),
                  ),
                );
              },
            ),
            CustomListTile(
              iconData: Icons.history,
              title: "History",
              active: widget.activeTileName == "history",
              onPressed: () {
                widget.activateListTile != null
                    ? widget.activateListTile!("history")
                    : null;
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => HistoryPage(),
                  ),
                );
              },
            ),
            CustomListTile(
              iconData: Icons.contact_page,
              title: "Contact Us",
              active: widget.activeTileName == "contactus",
              onPressed: () {
                widget.activateListTile != null
                    ? widget.activateListTile!("contactus")
                    : null;
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => ContactUsPage(),
                  ),
                );
              },
            ),
            CustomListTile(
              iconData: Icons.info,
              title: "About",
              active: widget.activeTileName == "about",
              onPressed: () {
                widget.activateListTile != null
                    ? widget.activateListTile!("about")
                    : null;
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => AboutPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const TextField(
      cursorColor: Colors.white30,
      style: TextStyle(
        color: Colors.white54,
      ),
      decoration: InputDecoration(
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintText: "Search...",
        hintStyle: TextStyle(color: Colors.white38),
        hoverColor: Colors.white10,
        prefixIcon: Icon(
          Icons.search,
          color: Colors.white54,
        ),
        filled: true,
      ),
    );
  }
}
