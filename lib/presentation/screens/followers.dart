import 'package:flutter/material.dart';
import '../../domain/entities/user_profile/user_profile.dart';
import '../components/user_followers.dart';

class ShowFollowers extends StatelessWidget {
  const ShowFollowers({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Followers(
            followers: userfollwing[index],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: userFollowers.length);
  }
}