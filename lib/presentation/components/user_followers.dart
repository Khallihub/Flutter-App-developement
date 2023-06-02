import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstash/application/user_profile_bloc/user_bloc.dart';
import 'package:picstash/application/user_profile_bloc/user_profile_event.dart';
import 'package:picstash/domain/entities/local_user_model.dart';
import 'package:picstash/domain/repositories/user_profile_repository.dart';
import 'package:picstash/infrastructure/data_providers/user_profile_data_provider.dart';
import 'package:picstash/presentation/components/custom_icons.dart';
import 'package:picstash/presentation/screens/error_page.dart';
import '../../application/user_profile_bloc/user_profile_state.dart';
import '../../assets/constants/assets.dart';
import 'package:flutter/material.dart';

class Followers extends StatefulWidget {
  final String follower;
  const Followers({super.key, required this.follower});

  @override
  State<Followers> createState() => _FollowersState();
}

class _FollowersState extends State<Followers> {
  @override
  void initState() {
    UserProfileBloc userProfileBloc = UserProfileBloc(
        userProfileRepository:
            UserProfileRepository(dataProvider: UserProfileDataProvider()));
    userProfileBloc.add(UserProfileLoadEvent(userEmail: widget.follower));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        if (state is UserProfileLoading) {
          BlocProvider.of<UserProfileBloc>(context)
              .add(UserProfileLoadEvent(userEmail: widget.follower));
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        switch (state.runtimeType) {
          case UserProfileLoadSuccess:
            LocalUserModel followerProfile = state.props[0] as LocalUserModel;
            return Row(
              children: [
                Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                            image: AssetImage(followerProfile.imageUrl),
                            fit: BoxFit.cover))),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      followerProfile.username,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      followerProfile.bio,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    )
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      color: Colors.deepPurpleAccent,
                      iconSize: 40,
                      icon: CustomIcons(src: CustomAssets.kChat),
                      onPressed: () {},
                    ),
                    IconButton(
                      color: Colors.blueAccent,
                      icon: const Icon(Icons.add_circle_outline, weight: 50),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            );
          default:
            return const ErrorPage();
        }
      },
    );
  }
}
