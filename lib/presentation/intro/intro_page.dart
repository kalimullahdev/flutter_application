import 'package:flutter/material.dart';
import 'package:flutter_application/presentation/intro/widgets/login_button.dart';
import 'package:flutter_application/presentation/intro/widgets/register_button.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 10) * 9,
                  child: Image.asset("assets/images/person.png"),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "LEST LEARN THE FLUTTER",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, dolor sit amet.",
                    textAlign: TextAlign.center,
                    style: TextStyle(height: 1.7),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                IntroRegisterButton(),
                SizedBox(width: 12),
                IntroLoginButton()
              ],
            )
          ],
        ),
      ),
    );
  }
}
