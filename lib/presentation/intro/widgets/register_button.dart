import 'package:flutter/material.dart';
import 'package:flutter_application/page_animations/size_route.dart';
import 'package:flutter_application/presentation/app.dart';
import 'package:flutter_application/presentation/auth/register/register_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntroRegisterButton extends ConsumerWidget {
  const IntroRegisterButton({
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
              SizeRoute(
                page: const RegisterPage(),
              ));
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(color: Colors.blue),
          )),
        ),
        child: const Text(
          "Register",
          style: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }
}
