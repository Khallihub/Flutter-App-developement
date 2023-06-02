import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:picstash/presentation/screens/error_page.dart';

import '../../application/user_profile_bloc/user_bloc.dart';
import '../../application/user_profile_bloc/user_profile_event.dart';
import '../../application/user_profile_bloc/user_profile_state.dart';
import '../../domain/entities/login/login_details.dart';
import '../../infrastructure/data_providers/db/db.dart';
import '../routes/app_route_constants.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  File? _avatarImage;

  Future<void> _pickImage() async {
    {
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
  }

  Future<LoginDetailsModel?> fetchLocalUser() async {
    LoginCredentials loginCredentials = LoginCredentials();
    return await loginCredentials.getLoginCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchLocalUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return BlocConsumer<UserProfileBloc, UserProfileState>(
                listener: (context, state) {
              if (state is UserProfileLoading) {
                BlocProvider.of<UserProfileBloc>(context).add(
                    UserProfileLoadEvent(
                        userEmail:
                            snapshot.data!.localUserModel.email.toString()));
              } else if (state is UserProfileError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                        "something went wrong, unable to perform the selected operation"),
                  ),
                );
              }
            }, builder: (context, state) {
              if (state is UserProfileLoading) {
                BlocProvider.of<UserProfileBloc>(context).add(
                    UserProfileLoadEvent(
                        userEmail:
                            snapshot.data!.localUserModel.email.toString()));
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              switch (state.runtimeType) {
                case UserProfileLoadSuccess:
                  String followingLength = state.props[2].toString();
                  String followersLength = state.props[1].toString();

                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Edit Profile'),
                    ),
                    body: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CircleAvatar(
                            radius: 50.0,
                            backgroundImage: NetworkImage(
                                snapshot.data!.localUserModel.imageUrl),
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            controller: _nameController,
                            decoration: InputDecoration(
                              labelText: 'Name',
                              labelStyle: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            controller: _bioController,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              labelText: 'Bio',
                              labelStyle: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: () {
                              // TODO: Implement image picker functionality here
                            },
                            child: Text(
                              'Add Image',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return Colors.blueAccent;
                                  }
                                  return Colors.blue;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );

                default:
                  return Scaffold(
                    body: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(child: Text("something wrong happend")),
                          Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  GoRouter.of(context).pushReplacementNamed(
                                      MyAppRouteConstants.homeRouteName);
                                },
                                child: const Text("Go Back")),
                          )
                        ]),
                  );
              }
            });
          } else {
            return const ErrorPage();
          }
        });
  }
}
