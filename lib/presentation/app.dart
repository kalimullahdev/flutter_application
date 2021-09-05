import 'package:flutter/material.dart';
import 'package:flutter_application/infrastructure/auth/auth_localservice.dart';
import 'package:flutter_application/inherited_widgets/auth/auth_service_inherited_widget.dart';
import 'package:flutter_application/presentation/auth/register/register_page.dart';
import 'package:flutter_application/presentation/home/home_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart';

final popPageProvider = StateNotifierProvider((ref) => PopPage());

class PopPage extends StateNotifier<bool> {
  PopPage() : super(false);
  // ignore: use_setters_to_change_properties
  void popPageState(bool value) => state = value;
}

class App extends StatefulWidget {
  final Database database;

  const App({
    Key? key,
    required this.database,
  }) : super(key: key);
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return AuthServiceInheritedWidget(
      authLocalService: AuthLocalservice(widget.database),
      child: MaterialApp(
        title: 'Material App',
        theme: ThemeData(
          brightness: Brightness.light,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color(0xff303030),
        ),
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
