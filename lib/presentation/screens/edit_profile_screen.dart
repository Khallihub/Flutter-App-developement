import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:picstash/presentation/screens/error_page.dart';
import '../../application/user_profile_bloc/user_bloc.dart';
import '../../application/user_profile_bloc/user_profile_event.dart';
import '../../application/user_profile_bloc/user_profile_state.dart';
import '../../domain/entities/login/login_details.dart';
import '../../infrastructure/data_providers/db/db.dart';
import '../../infrastructure/data_providers/upload_image.dart';
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
  String? avatarUrl;

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
                  return Scaffold(
                      appBar: AppBar(
                        title: const Text('Edit Profile'),
                        backgroundColor: Colors.grey[800],
                      ),
                      body: Container(
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
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: snapshot.data!.localUserModel.name,
                                prefixIcon: const Icon(Icons.person),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
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
                                labelText: snapshot.data!.localUserModel.bio,
                                prefixIcon: const Icon(Icons.info),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
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
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: const BorderSide(
                                    color: Colors.blue,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Edit Profile Image',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            ElevatedButton.icon(
                              onPressed: () {
                                var username = _nameController.text;
                                var bio = _bioController.text;
                                var password = _passwordController.toString();
                                if (username != "" ||
                                    bio != "" ||
                                    password != "") {
                                  BlocProvider.of<UserProfileBloc>(context).add(
                                    UserProfileUpdateEvent(
                                      email: snapshot.data!.localUserModel.email
                                          .toString(),
                                      userName: username.isEmpty
                                          ? snapshot
                                              .data!.localUserModel.username
                                          : username,
                                      bio: bio.isEmpty
                                          ? snapshot.data!.localUserModel.bio
                                          : bio,
                                      password: password,
                                    ),
                                  );
                                  _nameController.text = "";
                                  _bioController.text = "";
                                  _passwordController.text = "";
                                }
                              },
                              icon: const Icon(Icons.save),
                              label: const Text(
                                'Save',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.blue),
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));

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
