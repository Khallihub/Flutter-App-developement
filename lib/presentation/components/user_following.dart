import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../application/user_profile_bloc/user_bloc.dart';
import '../../application/user_profile_bloc/user_profile_event.dart';
import '../../application/user_profile_bloc/user_profile_state.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/local_user_model.dart';
import '../routes/app_route_constants.dart';
import '../screens/error_page.dart';

class Following extends StatefulWidget {
  final String following;
  const Following({super.key, required this.following});

  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  @override
  void initState() {
    BlocProvider.of<UserProfileBloc>(context).add(UserProfileInitEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        if (state is UserProfileLoading) {
          BlocProvider.of<UserProfileBloc>(context)
              .add(UserProfileLoadEvent(userEmail: widget.following));
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        switch (state.runtimeType) {
          case UserProfileLoadSuccess:
            LocalUserModel followingProfile = state.props[0] as LocalUserModel;
            return InkWell(
              onTap: (() => GoRouter.of(context).pushReplacementNamed(
                    MyAppRouteConstants.userProfile,
                    pathParameters: {
                      "username": followingProfile.username,
                      "bio": followingProfile.bio,
                      "avatar": followingProfile.imageUrl,
                      "id": followingProfile.id,
                      "name": followingProfile.name,
                      "email": followingProfile.email.toString(),
                      "role": "user"
                    },
                  )),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                color: Colors.white,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 15),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          followingProfile.imageUrl,
                        ),
                        radius: 35,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            followingProfile.name,
                            style: const TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w700),
                          ),
                          const Divider(
                            height: 5,
                          ),
                          Text(
                            "@${followingProfile.username}",
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 12),
                          )
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "@${followingProfile.username}",
                          style: const TextStyle(fontSize: 12),
                        )),
                  ],
                ),
              ),
            );
          default:
            return const ErrorPage();
        }
      },
    );
  }
}
