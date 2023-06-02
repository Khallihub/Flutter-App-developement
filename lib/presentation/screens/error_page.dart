import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key});

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                GoRouter.of(context).pop();
              },
              child: const Text("go back"))
        ],
      )),
    );
  }
}
