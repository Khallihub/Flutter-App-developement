import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../application/login_bloc/login_blocs.dart';
import '../../application/login_bloc/login_event.dart';
import '../../application/login_bloc/login_state.dart';
import '../../domain/entities/user_profile/user_profile.dart';
import '../../presentation/components/custom_icons.dart';
import '../../assets/constants/assets.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../components/follow_chip.dart';
import '../routes/app_route_constants.dart';
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
                content: Text("invalid credentials or connection problem"),
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
        if (!widget.isOwner)
          IconButton(
            iconSize: 60,
            icon: CustomIcons(src: CustomAssets.kChat),
            onPressed: () {},
          ),
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
  int buttonNumber = 1;

  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 375),
                childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: MediaQuery.of(context).size.width / 2,
                      child: FadeInAnimation(child: widget),
                    ),
                children: [
                  const SizedBox(height: 10),
                  Stack(
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
                              widget.userProfile.name,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      buttonNumber = 2;
                                    });
                                  },
                                  child: const Center(
                                      child: Text(
                                    '35.5k Followers',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 12),
                                  )),
                                ),
                                const SizedBox(width: 10),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      buttonNumber = 3;
                                    });
                                  },
                                  child: const Center(
                                      child: Text(
                                    '400 Followings',
                                    style: TextStyle(
                                        color: Colors.blue, fontSize: 12),
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
                                            color: Colors.blue, fontSize: 14)),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (!widget.isOwner) const FollowChip(),
                                if (!widget.isOwner)
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text("message",
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 14)),
                                  ),
                                if (!widget.isOwner)
                                  TextButton(
                                    onPressed: () {
                                      setState(() {
                                        buttonNumber = 1;
                                      });
                                    },
                                    child: const Text("Posts",
                                        style: TextStyle(
                                            color: Colors.blue, fontSize: 14)),
                                  ),
                              ],
                            )
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
                  const SizedBox(height: 20),
                  buttonNumber == 1
                      ? const ShowPosts()
                      : (buttonNumber == 2
                          ? const ShowFollowers()
                          : const ShowFollowings())
                ])));
  }
}
