import 'package:flutter/material.dart';
import '../../domain/entities/user_profile/user_profile.dart';
import '../components/user_following.dart';

class ShowFollowings extends StatelessWidget {
  const ShowFollowings({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Following(
            followers: userfollwing[index],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: userfollwing.length);
  }
}
