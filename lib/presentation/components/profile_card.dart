import 'package:picstash/domain/entities/post_model.dart';

import '../../assets/constants/assets.dart';
import 'package:flutter/material.dart';

import 'follow_chip.dart';
import '../../domain/entities/user_profile/user_profile.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  

 

  List<dynamic> currentList = [];

  // Initially empty list
  updateList(int buttonNumber) {
    setState(() {
      if (buttonNumber == 1) {
        currentList = dummyPosts;
      } else if (buttonNumber == 2) {
        currentList =  userFollowers;
      } else if (buttonNumber == 3) {
        currentList = userFollowers;
      } else {
        currentList = dummyPosts; // Invalid button number, empty list
      }
    });
  }

  @override
  void initState() {
    super.initState();
    // Set initial list to Button 1
    currentList = dummyPosts;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 50),
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 60, bottom: 20),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              const Text(
                "Anabel May",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: updateList(3),
                    child:const Center(
                        child: Text(
                      '35.5k Followers',
                      style: const TextStyle(color: Colors.blue, fontSize: 12),
                    )),
                  ),
                  SizedBox(width: 10),
                  TextButton(
                    onPressed: updateList(2),
                    child: Center(
                        child: Text(
                      '400 Followings',
                      style: const TextStyle(color: Colors.blue, fontSize: 12),
                    )),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FollowChip(),
                  TextButton(
                    onPressed: () {},
                    child: Text("send message",
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 14)),
                  ),
                  TextButton(
                    onPressed: updateList(1),
                    child: Text("Posts",
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 14)),
                  ),
                ],
              )
            ],
          ),
        ),
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(CustomAssets.kUser1),
        ),
      ],
    );
  }
}
