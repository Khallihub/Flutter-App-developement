import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotImplementedYet extends StatefulWidget {
  const NotImplementedYet({super.key});

  @override
  State<NotImplementedYet> createState() => _NotImplementedYetState();
}

class _NotImplementedYetState extends State<NotImplementedYet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("not implemented yet!"),
          TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue,
                textStyle: const TextStyle(),
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
