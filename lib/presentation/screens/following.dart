import 'package:flutter/material.dart';
import '../components/user_following.dart';

class ShowFollowings extends StatelessWidget {
  final List followings;
  const ShowFollowings({super.key, required this.followings});

  @override
  Widget build(BuildContext context) {
    // print("#" * 30);
    // print(followings);
    // print("#" * 30);
    return followings.isEmpty
        ? const Center(
            child: Text("You have no followings"),
          )
        : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Following(
                following: followings[index],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: followings.length);
  }
}
