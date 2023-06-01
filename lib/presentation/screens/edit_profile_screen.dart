import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstash/presentation/screens/error_page.dart';
import '../../application/user_profile_bloc/user_bloc.dart';
import '../../application/user_profile_bloc/user_profile_event.dart';
import '../../application/user_profile_bloc/user_profile_state.dart';
import '../../domain/entities/login/login_details.dart';
import '../../infrastructure/data_providers/db/db.dart';
import '../../infrastructure/data_providers/upload_image.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? avatarUrl;
  File? _avatarImage;
  final _formKey = GlobalKey<FormState>();

  Future<void> setAvatar() async {
    setState(() async {
      avatarUrl = await UploadImage.pickImage();
    });
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
                case UserProfileUpdateSuccess:
                case UserProfileLoadSuccess:
                  _usernameController.text =
                      snapshot.data!.localUserModel.username;
                  _bioController.text = snapshot.data!.localUserModel.bio;
                  return Scaffold(
                      appBar: AppBar(
                        title: const Text('Edit Profile'),
                        backgroundColor: Colors.grey[800],
                      ),
                      body: ListView(scrollDirection: Axis.vertical, children: [
                        Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  CircleAvatar(
                                    radius: 50.0,
                                    backgroundImage: NetworkImage(
                                        snapshot.data!.localUserModel.imageUrl),
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
                                    controller: _usernameController,
                                    validator: (value) {
                                      if (value == null || value == "") {
                                        return "invalid username";
                                      }
                                      return null;
                                    },
                                    onSaved: (newValue) {
                                      _usernameController.text = newValue!;
                                    },
                                    decoration: InputDecoration(
                                      labelText: "username",
                                      prefixIcon: const Icon(Icons.person),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          color: Colors.blue,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
                                    controller: _bioController,
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    decoration: InputDecoration(
                                      labelText: "bio",
                                      prefixIcon: const Icon(Icons.info),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          color: Colors.blue,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  TextFormField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      labelText: 'Edit Password',
                                      prefixIcon: const Icon(Icons.lock),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        borderSide: const BorderSide(
                                          color: Colors.blue,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 16.0),
                                  const SizedBox(height: 8.0),
                                  _avatarImage != null
                                      ? Image.file(_avatarImage!,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7)
                                      : Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.7,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
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
                                    onPressed: () async {
                                      setState(() async {
                                        avatarUrl =
                                            await UploadImage.pickImage();
                                      });
                                    },
                                    child: const Text('Choose Avatar'),
                                  ),
                                  const SizedBox(height: 16.0),
                                  const SizedBox(height: 16.0),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        var username = _usernameController.text;
                                        var bio = _bioController.text;
                                        var password =
                                            _passwordController.toString();
                                        BlocProvider.of<UserProfileBloc>(
                                                context)
                                            .add(
                                          UserProfileUpdateEvent(
                                              email: snapshot
                                                  .data!.localUserModel.email
                                                  .toString(),
                                              userName: username.isEmpty
                                                  ? snapshot.data!
                                                      .localUserModel.username
                                                  : username,
                                              bio: bio.isEmpty
                                                  ? snapshot
                                                      .data!.localUserModel.bio
                                                  : bio,
                                              password: password,
                                              avatarUrl: avatarUrl ??
                                                  snapshot.data!.localUserModel
                                                      .imageUrl),
                                        );
                                        _usernameController.text = "";
                                        _bioController.text = "";
                                        _passwordController.text = "";
                                      }
                                    },
                                    child: const Text(
                                      'Save',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ]));

                default:
                  return const ErrorPage();
              }
            });
          } else {
            return const ErrorPage();
          }
        });
  }
}
