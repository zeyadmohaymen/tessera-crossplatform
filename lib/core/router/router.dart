import 'package:flutter/material.dart';
import 'package:tessera/features/authentication/view/pages/google_login_placeholder_screen.dart';
import 'package:tessera/features/example/view/pages/example_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const GoogleLoginPlaceholderScreen(),
        );
      case '/second':
        return MaterialPageRoute(
          builder: (_) => Container(),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (_) => Container(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Container(),
        );
    }
  }
}
