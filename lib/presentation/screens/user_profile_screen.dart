import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../application/user_profile_bloc/user_bloc.dart';
import '../../application/user_profile_bloc/user_profile_event.dart';
import '../../application/user_profile_bloc/user_profile_state.dart';
import '../../domain/entities/login/login_details.dart';
import '../../domain/entities/user_profile/user_profile.dart';
import '../../infrastructure/data_providers/db/db.dart';
import '../../presentation/components/custom_icons.dart';
import '../../assets/constants/assets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../components/follow_chip.dart';
import 'package:get/get.dart';
import '../routes/app_route_constants.dart';
import 'edit_profile_screen.dart';
import './posts.dart';
import './followers.dart';
import './following.dart';

class UserProfileScreen extends StatefulWidget {
  final UserProfile userProfile;
  final bool isOwner;

  const UserProfileScreen({
    Key? key,
    required this.userProfile,
    required this.isOwner,
  }) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  List<dynamic> currentList = [];

  int buttonNumber = 1;

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

                  return GetMaterialApp(
                    home: Scaffold(
                        backgroundColor: Colors.grey[800],
                        appBar: AppBar(
                          elevation: 0,
                          backgroundColor: Colors.grey[700],
                          title: const Text("Profile",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black)),
                          actions: [
                            if (!widget.isOwner)
                              IconButton(
                                iconSize: 60,
                                icon: CustomIcons(src: CustomAssets.kChat),
                                onPressed: () {},
                              ),
                            if (widget.isOwner)
                              PopupMenuButton(
                                icon: const Icon(
                                  Icons.more_vert,
                                  color: Colors.black,
                                ),
                                itemBuilder: (context) => [
                                  const PopupMenuItem(
                                    value: 1,
                                    child: Text('Edit Profile'),
                                  ),
                                  const PopupMenuItem(
                                    value: 2,
                                    child: Text('LOg Out'),
                                  ),
                                  const PopupMenuItem(
                                    value: 3,
                                    child: Text('Setting'),
                                  ),
                                ],
                                onSelected: (value) {
                                  // Handle menu item selection
                                  if (value == 1) {
                                    Get.to(() => const EditProfileScreen());
                                  } else if (value == 2) {
                                    // Option 2 selected
                                  } else if (value == 3) {
                                    // Option 3 selected
                                  }
                                },
                              ),
                          ],
                        ),
                        body: AnimationLimiter(
                            child: ListView(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                children:
                                    AnimationConfiguration.toStaggeredList(
                                        duration:
                                            const Duration(milliseconds: 375),
                                        childAnimationBuilder: (widget) =>
                                            SlideAnimation(
                                              horizontalOffset:
                                                  MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                              child: FadeInAnimation(
                                                  child: widget),
                                            ),
                                        children: [
                                      const SizedBox(height: 10),
                                      // const ProfileCard(),
                                      Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 50),
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 60,
                                                bottom: 20),
                                            decoration: BoxDecoration(
                                                color: Colors.grey
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Column(
                                              children: [
                                                Text(
                                                  snapshot.data!.localUserModel
                                                      .name,
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          buttonNumber = 2;
                                                        });
                                                      },
                                                      child: Center(
                                                          child: Text(
                                                        "$followersLength Followers",
                                                        style: const TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 12),
                                                      )),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    TextButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          buttonNumber = 3;
                                                        });
                                                      },
                                                      child: Center(
                                                          child: Text(
                                                        '$followingLength following',
                                                        style: const TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 12),
                                                      )),
                                                    ),
                                                    if (widget.isOwner)
                                                      TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            buttonNumber = 1;
                                                          });
                                                        },
                                                        child: const Text(
                                                            "Posts",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontSize: 14)),
                                                      ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    if (!widget.isOwner)
                                                      const FollowChip(),
                                                    if (!widget.isOwner)
                                                      TextButton(
                                                        onPressed: () {},
                                                        child: const Text(
                                                            "send message",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontSize: 14)),
                                                      ),
                                                    if (!widget.isOwner)
                                                      TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            buttonNumber = 1;
                                                          });
                                                        },
                                                        child: const Text(
                                                            "Posts",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.blue,
                                                                fontSize: 14)),
                                                      ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          CircleAvatar(
                                            radius: 50,
                                            backgroundImage: NetworkImage(
                                                snapshot.data!.localUserModel
                                                    .imageUrl),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      buttonNumber == 1
                                          ? const ShowPosts()
                                          : (buttonNumber == 2
                                              ? const ShowFollowers()
                                              : const ShowFollowings())
                                    ])))),
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
          }
          return const Text("allahu akber");
        });
  }
}

//                     child: Container(
//                         padding: const EdgeInsets.all(20.0),
//                         child: SingleChildScrollView(
//                           child: Column(children: [
//                             Card(
//                                 child: Column(children: [
//                               Card(
//                                   elevation: 20,
//                                   child: Container(
//                                     color: Color.fromARGB(26, 235, 232, 232),
//                                     margin: EdgeInsets.all(20),
//                                     height: 200,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.stretch,
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.start,
//                                           children: [
//                                             CircleAvatar(
//                                               radius: 50.0,
//                                               backgroundImage: NetworkImage(
//                                                   widget.userProfile
//                                                       .profileImageUrl),
//                                             ),
//                                             SizedBox(width: 16.0),
//                                             Column(children: [
//                                               Text(
//                                                 "@${widget.userProfile.username}",
//                                                 style: TextStyle(
//                                                     fontSize: 20.0,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: Color.fromARGB(
//                                                         255, 25, 27, 122)),
//                                               ),
//                                               SizedBox(height: 16.0),
//                                               Text("Shemsedin",
//                                                   style: TextStyle(
//                                                       fontSize: 20.0,
//                                                       fontWeight:
//                                                           FontWeight.bold))
//                                             ]),
//                                           ],
//                                         ),
//                                         SizedBox(height: 16.0),
//                                         Container(
//                                             height: 75,
//                                             child: Text(
//                                               widget.userProfile.bio,
//                                               style: TextStyle(fontSize: 16.0),
//                                               textAlign: TextAlign.center,
//                                             )),
//                                       ],
//                                     ),
//                                   )),
//                               Center(
//                                   child: Row(
//                                 children: [
//                                   const Padding(padding: EdgeInsets.all(10)),
//                                   Expanded(
//                                       child: ElevatedButton(
//                                           style: ButtonStyle(
//                                               elevation:
//                                                   MaterialStatePropertyAll(0.0),
//                                               backgroundColor:
//                                                   MaterialStatePropertyAll(
//                                                       Color.fromARGB(
//                                                           255, 5, 143, 120))),
//                                           onPressed: () {
//                                             updateList(1);
//                                           },
//                                           child: Text("Posts"))),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Expanded(
//                                       child: ElevatedButton(
//                                           style: ButtonStyle(
//                                               elevation:
//                                                   MaterialStatePropertyAll(0.0),
//                                               backgroundColor:
//                                                   MaterialStatePropertyAll(
//                                                       Color.fromARGB(
//                                                           255, 5, 143, 120))),
//                                           onPressed: () {
//                                             updateList(2);
//                                           },
//                                           child: const Text("following"))),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Expanded(
//                                       child: ElevatedButton(
//                                     style: ButtonStyle(
//                                         elevation:
//                                             MaterialStatePropertyAll(0.0),
//                                         backgroundColor:
//                                             MaterialStatePropertyAll(
//                                                 Color.fromARGB(
//                                                     255, 5, 143, 120))),
//                                     onPressed: () {
//                                       updateList(3);
//                                     },
//                                     child: Text("followers"),
//                                   )),
//                                   const Padding(padding: EdgeInsets.all(10)),
//                                 ],
//                               ))
//                             ])),
//                             SizedBox(
//                                 height: 16.0,
//                                 child: Card(
//                                   elevation: 20,
//                                 )),
//                             SingleChildScrollView(
//                               child: Container(
//                                 height: MediaQuery.of(context)
//                                     .size
//                                     .height, // Provide a specific height constraint
//                                 child: ListView.builder(
//                                     itemCount: currentList.length,
//                                     itemBuilder: (BuildContext context, index) {
//                                       if (currentList == Posts) {
//                                         return Image.network(
//                                           Posts[index],
//                                           fit: BoxFit.cover,
//                                         );
//                                       } else {
//                                         return Center(
//                                           child: Card(
//                                               child: Row(
//                                             children: [
//                                               CircleAvatar(
//                                                 radius: 25.0,
//                                                 backgroundImage: NetworkImage(
//                                                     widget.userProfile
//                                                         .profileImageUrl),
//                                               ),
//                                               SizedBox(
//                                                 width: 10,
//                                               ),
//                                               Text(
//                                                 "Shemsedin",
//                                                 style: TextStyle(
//                                                     color: Colors.black,
//                                                     fontSize: 20),
//                                               )
//                                             ],
//                                           )),
//                                         );
//                                       }
//                                     }),
//                               ),
//                             )
//                           ]),
//                         )));
//               },
//             ),
//           ),
//         ));
//   }
// }
