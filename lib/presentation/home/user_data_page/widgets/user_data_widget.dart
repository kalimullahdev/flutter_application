import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application/inherited_widgets/auth/auth_service_inherited_widget.dart';
import 'package:flutter_application/models/auth/user_entity.dart';
import 'package:flutter_application/presentation/home/home_page.dart';

class UserDataWidget extends StatefulWidget {
  const UserDataWidget({
    Key? key,
  }) : super(key: key);

  @override
  _UserDataWidgetState createState() => _UserDataWidgetState();
}

class _UserDataWidgetState extends State<UserDataWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
            future:
                AuthServiceInheritedWidget.of(context).authLocalService.users(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Expanded(
                  child: Center(
                    child: ListView.builder(
                        itemCount: (snapshot.data as List<User>).length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(
                              (snapshot.data[index] as User).email,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              "${(snapshot.data[index] as User).dateOfBirth} date",
                            ),
                          );
                        }),
                  ),
                );
              }
            },
          ),
          ElevatedButton(
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  ),
              child: const Text("Home Page"))
        ],
      ),
    );
  }
}
