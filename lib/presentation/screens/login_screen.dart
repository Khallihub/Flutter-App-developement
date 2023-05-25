import 'package:flutter/material.dart';

import '../components/top_curved_container.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: MyWidget(),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 35, bottom: 35),
              child: Container(
                padding: const EdgeInsets.all(50),
                child: Image.asset(
                  'lib/assets/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const LoginBody(),
          ],
        ),
      ),
    );
  }
}

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  String clickedTab = "login";

  void changeTab() {
    setState(() {
      clickedTab == "login" ? clickedTab = "signup" : clickedTab = "login";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TopCurvedContainer(
        radius: 50,
        color: const Color.fromARGB(255, 55, 107, 238),
        child: Column(children: [
          Container(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: changeTab,
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 25,
                            color: clickedTab == "login"
                                ? Colors.grey
                                : Colors.white),
                      )),
                  TextButton(
                      onPressed: changeTab,
                      child: Text(
                        "Signup",
                        style: TextStyle(
                            fontSize: 25,
                            color: clickedTab == "signup"
                                ? Colors.grey
                                : Colors.white),
                      ))
                ],
              )),
          const Expanded(
            child: TopCurvedContainer(
              color: Colors.white,
              radius: 50,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(40),
                  child: LoginForm(),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
