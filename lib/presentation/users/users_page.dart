import 'package:flutter/material.dart';
import 'package:flutter_application/enums/user_actions.dart';
import 'package:flutter_application/inherited_widgets/auth/auth_service_inherited_widget.dart';
import 'package:flutter_application/models/auth/user_entity.dart';
import 'package:flutter_application/presentation/navigations/app_drawer/app_drawer.dart';
import 'package:flutter_application/presentation/users/edit_user_page.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<User> users = <User>[];

  @override
  void didChangeDependencies() {
    AuthServiceInheritedWidget.of(context).authLocalService.users().then(
          (value) => setState(() {
            users = value;
          }),
        );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(
        activeTileName: "chat",
      ),
      appBar: AppBar(
        title: const Text('Users Page'),
      ),
      body: FutureBuilder(
        future: AuthServiceInheritedWidget.of(context).authLocalService.users(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return AnimatedList(
              initialItemCount: users.length,
              itemBuilder:
                  (BuildContext context, int index, Animation animation) {
                return aListTile(index, context);
              },
            );
          }
        },
      ),
    );
  }

  ListTile aListTile(int index, BuildContext context) {
    return ListTile(
      title: Text(
        (users[index]).name,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        (users[index]).dateOfBirth,
      ),
      trailing: PopupMenuButton<SingleUserActions>(
        onSelected: (SingleUserActions result) {
          if (result == SingleUserActions.edit) {
            //Edit action
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditUserPage(
                  userId: (users[index]).id,
                ),
              ),
            );
          } else {
            //Delete action
            final Widget cancelButton = TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            );
            final Widget yesButton = TextButton(
              onPressed: () {
                AuthServiceInheritedWidget.of(context)
                    .authLocalService
                    .deleteUser((users[index]).id);
                AnimatedList.of(context).removeItem(
                  index,
                  (context, animation) => slideIt(context, index, animation),
                  duration: const Duration(seconds: 1),
                );
                Navigator.pop(context);
              },
              child: const Text("Yes"),
            );

            final altertDialog = AlertDialog(
              title: Row(
                children: const [
                  Icon(Icons.delete),
                  SizedBox(width: 8),
                  Text('Conform delete'),
                ],
              ),
              content: const Text('Are you sure, you want to delete the user?'),
              actions: <Widget>[
                cancelButton,
                yesButton,
              ],
            );

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return altertDialog;
              },
            );
          }
        },
        itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<SingleUserActions>>[
          const PopupMenuItem<SingleUserActions>(
            value: SingleUserActions.edit,
            child: Text('Edit'),
          ),
          const PopupMenuItem<SingleUserActions>(
            value: SingleUserActions.delete,
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget slideIt(BuildContext context, int index, Animation<double> animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: aListTile(index, context),
    );
  }
}
