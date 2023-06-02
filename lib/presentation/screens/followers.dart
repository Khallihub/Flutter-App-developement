import 'package:flutter/material.dart';
import '../components/user_followers.dart';

class ShowFollowers extends StatelessWidget {
  final List followers;
  const ShowFollowers({super.key, required this.followers});

  @override
  Widget build(BuildContext context) {
    return followers.isEmpty
        ? const Center(
            child: Text("You have no follower"),
          )
        : ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Followers(
                follower: followers[index],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemCount: followers.length);
  }
}
