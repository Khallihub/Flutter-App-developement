import 'package:picstash/domain/entities/user_profile/models.dart';
import 'package:picstash/presentation/components/custom_icons.dart';
import '../../assets/constants/assets.dart';
import 'package:flutter/material.dart';

class Following extends StatefulWidget {
  final UserProfile followers;
  const Following({super.key, required this.followers});

  @override
  State<Following> createState() => _FollowingState();
}

class _FollowingState extends State<Following> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    image: AssetImage(widget.followers.avatar),
                    fit: BoxFit.cover))),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.followers.userName,
              style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            const SizedBox(height: 2),
            Text(
              widget.followers.location,
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
              color: Colors.redAccent,
              icon: const Icon(Icons.remove_circle_outline_sharp, weight: 50),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}