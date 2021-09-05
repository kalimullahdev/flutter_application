import 'package:flutter/material.dart';
import 'package:flutter_application/page_animations/rotation_route.dart';
import 'package:flutter_application/presentation/app.dart';
import 'package:flutter_application/presentation/auth/register/register_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DonotHaveAccountWidget extends ConsumerWidget {
  const DonotHaveAccountWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text("Don't have account?"),
        TextButton(
            onPressed: () {
              final bool popvalue = watch(popPageProvider.notifier).state;
              if (popvalue == false) {
                watch(popPageProvider.notifier).popPageState(true);
                Navigator.push(
                    context,
                    RotationRoute(
                      page: RegisterPage(),
                    ));
              } else {
                watch(popPageProvider.notifier).popPageState(false);
                Navigator.pop(context);
              }
            },
            child: const Text("Register")),
      ],
    );
  }
}
