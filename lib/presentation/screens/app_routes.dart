import 'package:flutter/material.dart';
import 'package:picstash/presentation/screens/login_screen.dart';

class AppRoute {
  static Route generateRoute(RouteSettings settings) {
    if (settings.name == "/") {
      return MaterialPageRoute(builder: (context) => const LogIn());
    } else {
      return MaterialPageRoute(
          builder: ((context) => Scaffold(
                appBar: AppBar(leading: const Text("Hello")),
                body: const Center(child: Text("whatevr")),
              )));
    }
  }
}
