// import 'package:flutter/material.dart';
// import 'package:file_picker/file_picker.dart';
// import 'dart:io';

// class MyRegister extends StatefulWidget {
//   const MyRegister({Key? key}) : super(key: key);

//   @override
//   State<MyRegister> createState() => _MyRegisterState();
// }

// class _MyRegisterState extends State<MyRegister> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController avatarController = TextEditingController();
//   final TextEditingController bioController = TextEditingController();
//   final TextEditingController usernameController = TextEditingController();

//   File? _avatarImage;

//   Future<void> _pickAvatarImage() async {
//     final result = await FilePicker.platform.pickFiles(
//       type: FileType.image,
//       allowMultiple: false,
//     );

//     if (result != null && result.files.isNotEmpty) {
//       final path = result.files.first.path;
//       if (path != null) {
//         setState(() {
//           _avatarImage = File(path);
//           avatarController.text = path;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               children: [
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width * 0.7,
//                   child: Image.asset("lib/assets/logo.png"),
//                 ),
//                 const SizedBox(height: 16.0),
//                 TextField(
//                   controller: nameController,
//                   decoration: const InputDecoration(
//                     labelText: 'Name',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 8.0),
//                 TextField(
//                   controller: emailController,
//                   decoration: const InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 8.0),
//                 TextField(
//                   controller: passwordController,
//                   decoration: const InputDecoration(
//                     labelText: 'Password',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 8.0),
//                 TextField(
//                   controller: avatarController,
//                   decoration: const InputDecoration(
//                     labelText: 'Avatar',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 ElevatedButton(
//                   onPressed: _pickAvatarImage,
//                   child: const Text('Select Avatar Image'),
//                 ),
//                 _avatarImage != null
//                     ? Image.file(
//                         _avatarImage!,
//                         height: 100,
//                         width: 100,
//                       )
//                     : const SizedBox(height: 100),
//                 const SizedBox(height: 8.0),
//                 TextField(
//                   controller: bioController,
//                   decoration: const InputDecoration(
//                     labelText: 'Bio (Optional)',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 8.0),
//                 TextField(
//                   controller: usernameController,
//                   decoration: const InputDecoration(
//                     labelText: 'Username',
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 16.0),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Register button pressed
//                     final String name = nameController.text;
//                     final String email = emailController.text;
//                     final String password = passwordController.text;
//                     final String avatar = avatarController.text;
//                     final String bio = bioController.text;
//                     final String username = usernameController.text;

//                     // Perform registration logic here

//                     // Example code: Printing the entered values
//                     print('Name: $name');
//                     print('Email: $email');
//                     print('Password: $password');
//                     print('Avatar: $avatar');
//                     print('Bio: $bio');
//                     print('Username: $username');
//                   },
//                   child: const Padding(
//                     padding: EdgeInsets.symmetric(
//                       vertical: 10.0,
//                       horizontal: 20.0,
//                     ),
//                     child: Text('Register'),
//                   ),
//                 ),
//                 const SizedBox(height: 8.0),
//                 TextButton(
//                   onPressed: () {
//                     // Login Instead button pressed
//                   },
//                   child: const Text(
//                     'Login Instead?',
//                     style: TextStyle(
//                       color: Colors.blue,
//                       fontSize: 16.0,
//                       decoration: TextDecoration.underline,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:picstash/application/signup_bloc/sign_up_block.dart';
import 'package:picstash/application/signup_bloc/sign_up_event.dart';
import 'package:picstash/domain/entities/signup/sign_up_model.dart';
import 'package:picstash/domain/value_objects/avatar.dart';
import 'package:picstash/domain/value_objects/email_address.dart';
import 'package:picstash/domain/value_objects/password.dart';
import 'package:picstash/infrastructure/data_providers/signup/signup_data_provider.dart';
import 'package:picstash/infrastructure/repository/signup_repository/sign_up_repository.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  State<MyRegister> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();

  final SignUpBloc signUpBloc = SignUpBloc(
      signUpRepository:
          SignUpRepository(signUpDataProvider: SignUpDataProvider()));

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
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    _avatarImage != null
                        ? Image.file(
                            _avatarImage!,
                            height: 100.0,
                          )
                        : const Placeholder(
                            fallbackHeight: 100.0,
                          ),
                    const SizedBox(height: 8.0),
                    TextButton(
                      onPressed: _pickAvatarImage,
                      child: const Text('Choose Avatar'),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: bioController,
                      decoration: const InputDecoration(
                        labelText: 'Bio (Optional)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        SignUpModel signUpModel = SignUpModel.create(
                            nameController.text,
                            EmailAddress.create(emailController.text)
                                as EmailAddress,
                            Password.create(passwordController.text)
                                as Password,
                            usernameController.text,
                            bio: bioController.text,
                            avatar: AvatarModel.create(
                                "https://picsum.photos/400"));

                        signUpBloc
                            .add(SignUpButtonPressed(signUpModel: signUpModel));
                      },
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10.0,
                          horizontal: 20.0,
                        ),
                        child: Text('Register'),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    TextButton(
                      onPressed: () {
                        // Login Instead button pressed
                      },
                      child: const Text(
                        'Login Instead?',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16.0,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
