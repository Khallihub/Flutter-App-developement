import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:picstash/application/login_bloc/login_blocs.dart';
import 'package:picstash/infrastructure/data_providers/login/login_data_provider.dart';
import 'package:picstash/infrastructure/repository/login_repository/login_repository.dart';
import '../../domain/value_objects/email_address.dart';
import '../../domain/value_objects/password.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  late String _email;
  late String _password;
  final LoginBloc loginBloc = LoginBloc(
      loginRepository: LoginRepository(loginDataProvider: LoginDataProvider()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Image.asset("lib/assets/logo.png"),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder()),
                            validator: ((value) {
                              if (!EmailAddress.isValidEmail(value!)) {
                                return "invalid email!";
                              }
                              return null;
                            }),
                            onSaved: (value) {
                              setState(() {
                                _email = value!;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(35, 10, 35, 10),
                          child: TextFormField(
                            obscureText: true,
                            decoration: const InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder()),
                            validator: (value) {
                              if (!Password.isValidPassword(value!)) {
                                return "invalid password";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              setState(() {
                                _password = newValue!;
                              });
                            },
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.blueGrey[100]),
                                  ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: const Color(0xff4c505b),
                                    child: IconButton(
                                      color: Colors.white,
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                        }
                                        stdout.write("email: $_email");
                                        stdout.write("password: $_password");
                                      },
                                      icon: const Icon(Icons.arrow_forward),
                                    ),
                                  ),
                                ])),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have account yet?"),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.blue,
                                textStyle: const TextStyle(),
                              ),
                              onPressed: () {
                                GoRouter.of(context).pushNamed("register");
                              },
                              child: const Text(
                                'Create account now',
                                style: TextStyle(
                                  decoration: TextDecoration
                                      .underline, // Add text underline decoration
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
