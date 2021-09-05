import 'package:flutter/material.dart';
import 'package:flutter_application/page_animations/fade_route.dart';
import 'package:flutter_application/presentation/app.dart';
import 'package:flutter_application/presentation/auth/login/login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlreadyHaveAccount extends ConsumerWidget {
  const AlreadyHaveAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Already have account?"),
        TextButton(
            onPressed: () {
              final bool popvalue = watch(popPageProvider.notifier).state;
              if (popvalue == false) {
                watch(popPageProvider.notifier).popPageState(true);
                Navigator.push(context, FadeRoute(page: LoginPage()));
              } else {
                watch(popPageProvider.notifier).popPageState(false);
                Navigator.pop(context);
              }
            },
            child: const Text("Login")),
      ],
    );
  }
}
