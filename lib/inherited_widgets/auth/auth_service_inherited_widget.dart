import 'package:flutter/material.dart';
import 'package:flutter_application/infrastructure/auth/auth_localservice.dart';

class AuthServiceInheritedWidget extends InheritedWidget {
  const AuthServiceInheritedWidget({
    Key? key,
    required this.authLocalService,
    required Widget child,
  }) : super(key: key, child: child);

  final AuthLocalservice authLocalService;

  static AuthServiceInheritedWidget of(BuildContext context) {
    final AuthServiceInheritedWidget? result = context
        .dependOnInheritedWidgetOfExactType<AuthServiceInheritedWidget>();
    assert(result != null, 'No AuthServiceInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(AuthServiceInheritedWidget old) =>
      authLocalService != old.authLocalService;
}
