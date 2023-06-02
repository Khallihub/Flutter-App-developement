import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../routes/app_route_constants.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("something went wrong"),
          TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.green[200],
                textStyle: const TextStyle(color: Colors.black),
              ),
              onPressed: () {
                GoRouter.of(context)
                    .pushReplacementNamed(MyAppRouteConstants.homeRouteName);
              },
              child: const Text("go back"))
        ],
      ),
    );
  }
}
