import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:picstash/application/signup_bloc/sign_up_block.dart';
import 'package:picstash/application/signup_bloc/sign_up_event.dart';
import 'package:picstash/domain/entities/signup/sign_up_model.dart';
import 'package:picstash/domain/value_objects/avatar.dart';
import 'package:picstash/domain/value_objects/email_address.dart';
import 'package:picstash/domain/value_objects/password.dart';
import 'package:picstash/presentation/routes/app_route_constants.dart';
import '../../application/signup_bloc/sign_up_state.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(listener: (context, state) {
      if (state is SignUpSuccess) {
        GoRouter.of(context)
            .pushReplacementNamed(MyAppRouteConstants.loginRouteName);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "account created successfully, click on the login button to log into your account"),
          ),
        );
      } else if (state is SignUpFailure) {
        {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("something went wrong, please try again"),
            ),
          );
        }
      }
    }, builder: (context, state) {
      switch (state.runtimeType) {
        case SignUpInitial || SignUpFailure || SignUpSuccess:
          return const SignUpBody();
        case SignUpLoading:
          return const Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));

        default:
          return const Scaffold(
            body: Center(
              child: Text("something went wrong"),
            ),
          );
      }
    });
  }
}

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final _formKey = GlobalKey<FormState>();
  static String _name = "";
  static String _emailAddress = "";
  static String _password = "";
  static String _bio = "";
  static String _username = "";
  File? _avatarImage;
  // String? _avatarImageUrl;

  Future<void> _pickAvatarImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      final path = result.files.first.path;
      if (path != null) {
        setState(() {
          _avatarImage = File(path);
        });
      }
    }
  }

  // Future<void> _uploadAvatarImage() async {
  //   // Perform the upload logic here, such as sending the photo to a server
  //   // and getting back the URL or identifier for accessing the photo later
  //   // Replace this code with your actual implementation

  //   // Simulating the upload process with a delay
  //   await Future.delayed(const Duration(seconds: 2));

  //   // Example response from the server
  //   const uploadedImageUrl = 'https://example.com/uploads/avatar123.jpg';

  //   setState(() {
  //     _avatarImageUrl = uploadedImageUrl;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Image.asset("lib/assets/logo.png"),
                ),
                const SizedBox(height: 8.0),
                Form(
                  key: _formKey,
                  child: Column(children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: ((newValue) {
                        setState(() {
                          _name = newValue!;
                        });
                      }),
                      validator: (value) {
                        if (value == null || value == "") {
                          return "invalid name";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      validator: (value) {
                        if (!EmailAddress.isValidEmail(value!)) {
                          return "invalid email!";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        setState(() {
                          _emailAddress = newValue!;
                        });
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (newValue) {
                        setState(() {
                          _password = newValue!;
                        });
                      },
                      validator: (value) {
                        if (!Password.isValidPassword(value!)) {
                          return "invalid password";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8.0),
                    _avatarImage != null
                        ? Image.file(_avatarImage!,
                            height: MediaQuery.of(context).size.width * 0.7)
                        : Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloud_upload,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Upload Image',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    const SizedBox(height: 8.0),
                    TextButton(
                      onPressed: _pickAvatarImage,
                      child: const Text('Choose Avatar'),
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      onSaved: (newValue) {
                        setState(() {
                          _bio = newValue!;
                        });
                      },
                      decoration: const InputDecoration(
                        labelText: 'Bio (Optional)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value == "") {
                          return "invalid username";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _username = newValue!;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xff4c505b)),
                      ),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          SignUpModel signUpModel = SignUpModel.create(
                              _name,
                              EmailAddress.crud(_emailAddress),
                              Password.crud(_password),
                              _username,
                              bio: _bio,
                              avatar: AvatarModel.create(
                                  "https://picsum.photos/400"));
                          BlocProvider.of<SignUpBloc>(context).add(
                              SignUpButtonPressed(signUpModel: signUpModel));
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20.0,
                        ),
                        child: Text('Register'),
                      ),
                    ),
                  ]),
                ),
                const SizedBox(height: 8.0),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.blue,
                    textStyle: const TextStyle(),
                  ),
                  onPressed: () {
                    GoRouter.of(context).push("/login");
                  },
                  child: const Text(
                    'Log in instead?',
                    style: TextStyle(
                      decoration: TextDecoration
                          .underline, // Add text underline decoration
                    ),
                  ),
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
