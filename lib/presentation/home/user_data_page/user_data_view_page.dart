import 'package:flutter/material.dart';
import 'package:flutter_application/presentation/home/user_data_page/widgets/user_data_widget.dart';

class UserDataViewPage extends StatefulWidget {
  const UserDataViewPage({
    Key? key,
  }) : super(key: key);

  @override
  _UserDataViewPageState createState() => _UserDataViewPageState();
}

class _UserDataViewPageState extends State<UserDataViewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: const Center(
          child: Text(
            "User data page",
            style: TextStyle(
              color: Colors.black87,
            ),
          ),
        ),
      ),
      body: const Center(
        child: UserDataWidget(),
      ),
    );
  }
}
