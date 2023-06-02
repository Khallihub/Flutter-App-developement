import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:picstash/domain/entities/login/login_details.dart';
import 'package:picstash/infrastructure/data_providers/db/db.dart';
import '../../application/chat_bloc/chat_bloc.dart';
import '../../application/chat_bloc/chat_event.dart';
import '../../application/login_bloc/login_blocs.dart';
import '../../application/login_bloc/login_event.dart';
import '../../application/login_bloc/login_state.dart';
import '../../application/user_profile_bloc/user_bloc.dart';
import '../../application/user_profile_bloc/user_profile_event.dart';
import '../../application/user_profile_bloc/user_profile_state.dart';
import '../../domain/entities/user_profile/user_profile.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../routes/app_route_constants.dart';
import './posts.dart';
import './followers.dart';
import './following.dart';
import 'error_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
        bloc: BlocProvider.of<LoginBloc>(context),
        listener: (context, state) {
          if (state is LogOutSuccess) {
            GoRouter.of(context).pushReplacement("/login");
          } else if (state is LogOutFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("something went wrong, please try again!"),
              ),
            );
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case LogOutLoading:
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
          }
          return Scaffold(
              appBar: CustomAppBar(
                userProfile: widget.userProfile,
                isOwner: widget.isOwner,
              ),
              body: ProfileBody(
                userProfile: widget.userProfile,
                isOwner: widget.isOwner,
              ));
        });
  }
}

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final UserProfile userProfile;
  final bool isOwner;
  const CustomAppBar(
      {super.key, required this.userProfile, required this.isOwner});
  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late String _selectedOption;

  final List<String> _menuOptions = [
    'Edit Profile',
    'Settings',
    'Log out',
  ];

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.grey[800],
      title: const Text("Profile",
          style: TextStyle(fontSize: 18, color: Colors.white)),
      actions: [
        if (widget.isOwner)
          PopupMenuButton<String>(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onSelected: (String value) {
              setState(() {
                _selectedOption = value;
              });
              if (_selectedOption == "Edit Profile") {
                GoRouter.of(context)
                    .pushNamed(MyAppRouteConstants.editProfileRouteName);
              } else if (_selectedOption == "Settings") {
                GoRouter.of(context)
                    .pushNamed(MyAppRouteConstants.notImplemented);
              } else if (_selectedOption == "Log out") {
                BlocProvider.of<LoginBloc>(context).add(
                  LogOutButtonPressed(),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return _menuOptions.map((String option) {
                return PopupMenuItem<String>(
                  value: option,
                  child: Text(
                    option,
                    style: const TextStyle(color: Colors.white),
                  ),
                );
              }).toList();
            },
            offset: const Offset(0, 50),
            color: Colors.grey[700],
          )
      ],
    );
  }
}

class ProfileBody extends StatefulWidget {
  final UserProfile userProfile;
  final bool isOwner;

  const ProfileBody(
      {super.key, required this.userProfile, required this.isOwner});

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  @override
  void initState() {
    BlocProvider.of<UserProfileBloc>(context)
        .add(UserProfileLoadEvent(userEmail: widget.userProfile.email));
    super.initState();
  }

  int buttonNumber = 1;
  @override
  Widget build(BuildContext context) {
    Future<LoginDetailsModel?> fetchLocalUser() async {
      return await LoginCredentials().getLoginCredentials();
    }

    return BlocConsumer<UserProfileBloc, UserProfileState>(
        listener: (context, state) {
      if (state is UserProfileLoading) {
        BlocProvider.of<UserProfileBloc>(context).add(UserProfileLoadEvent(
            userEmail: widget.userProfile.email.toString()));
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
        BlocProvider.of<UserProfileBloc>(context).add(UserProfileLoadEvent(
            userEmail: widget.userProfile.email.toString()));
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      switch (state.runtimeType) {
        case UserProfileLoading:
          BlocProvider.of<UserProfileBloc>(context).add(UserProfileLoadEvent(
              userEmail: widget.userProfile.email.toString()));
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        case UserProfileLoadSuccess:
          return FutureBuilder(
              future: fetchLocalUser(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return AnimationLimiter(
                      child: ListView(
                          children: AnimationConfiguration.toStaggeredList(
                              duration: const Duration(milliseconds: 375),
                              childAnimationBuilder: (widget) => SlideAnimation(
                                    horizontalOffset:
                                        MediaQuery.of(context).size.width / 2,
                                    child: FadeInAnimation(child: widget),
                                  ),
                              children: [
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 50),
                                padding: const EdgeInsets.only(
                                    left: 10, right: 10, top: 60, bottom: 20),
                                decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  children: [
                                    Text(
                                      widget.userProfile.userName,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    const SizedBox(height: 10),
                                    const SizedBox(height: 10),
                                    !widget.isOwner
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Padding(
                                                  padding: EdgeInsets.all(5)),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15,
                                                        vertical: 8),
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                child: Row(
                                                  children: [
                                                    const Icon(Icons.add,
                                                        color: Colors.white,
                                                        size: 20),
                                                    const SizedBox(width: 2),
                                                    TextButton(
                                                      child: (state.props[1]
                                                                  as List)
                                                              .contains(snapshot
                                                                  .data!
                                                                  .localUserModel
                                                                  .email
                                                                  .toString())
                                                          ? const Text(
                                                              "Unfollow",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14),
                                                            )
                                                          : const Text(
                                                              "Follow",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14),
                                                            ),
                                                      onPressed: () {
                                                        BlocProvider.of<
                                                                    UserProfileBloc>(
                                                                context)
                                                            .add(UserProfileFollowEvent(
                                                                followerUsername:
                                                                    snapshot
                                                                        .data!
                                                                        .localUserModel
                                                                        .username,
                                                                followedUsername: widget
                                                                    .userProfile
                                                                    .userName));

                                                        BlocProvider.of<
                                                                    UserProfileBloc>(
                                                                context)
                                                            .add(UserProfileLoadEvent(
                                                                userEmail: widget
                                                                    .userProfile
                                                                    .email));
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  BlocProvider.of<ChatBloc>(
                                                          context)
                                                      .add(ChatCreateEvent(
                                                          snapshot
                                                              .data!
                                                              .localUserModel
                                                              .username,
                                                          widget.userProfile
                                                              .userName));
                                                  GoRouter.of(context)
                                                      .pushReplacementNamed(
                                                    MyAppRouteConstants
                                                        .chatRouteName,
                                                    pathParameters: {
                                                      "id":
                                                          widget.userProfile.id,
                                                      "user1": snapshot
                                                          .data!
                                                          .localUserModel
                                                          .username,
                                                      "user2": widget
                                                          .userProfile.userName,
                                                      "friendName": widget
                                                          .userProfile.name,
                                                      "friendImage": widget
                                                          .userProfile.avatar
                                                    },
                                                  );
                                                },
                                                child: const Text(
                                                    "Send Message",
                                                    style: TextStyle(
                                                        color: Colors.blue,
                                                        fontSize: 14)),
                                              ),
                                              const Padding(
                                                  padding: EdgeInsets.all(5)),
                                            ],
                                          )
                                        : Row(
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
                                                  "${((state.props[1] as List).length).toString()} Followers",
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
                                                  '${((state.props[2] as List).length).toString()} Following',
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
                                                  child: const Text("Posts",
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 14)),
                                                ),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                              CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    NetworkImage(widget.userProfile.avatar),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        widget.isOwner
                            ? buttonNumber == 1
                                ? ShowPosts(
                                    username:
                                        snapshot.data!.localUserModel.username)
                                : (buttonNumber == 2
                                    ? ShowFollowers(
                                        followers: state.props[1] as List,
                                      )
                                    : ShowFollowings(
                                        followings: state.props[2] as List,
                                      ))
                            : ShowPosts(username: widget.userProfile.userName),
                      ])));
                } else {
                  return const ErrorPage();
                }
              }));
        default:
          return const ErrorPage();
      }
    });
  }
}
