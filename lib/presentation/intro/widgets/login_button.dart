import 'package:flutter/material.dart';
import 'package:flutter_application/page_animations/scale_route.dart';
import 'package:flutter_application/presentation/app.dart';
import 'package:flutter_application/presentation/auth/login/login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntroLoginButton extends ConsumerWidget {
  const IntroLoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: ElevatedButton(
        onPressed: () {
          watch(popPageProvider.notifier).popPageState(false);
          Navigator.push(
              context,
              ScaleRoute(
                page: LoginPage(),
              ));
        },
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: const BorderSide(color: Colors.blue))),
        ),
        child: const Text(
          "Login",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
