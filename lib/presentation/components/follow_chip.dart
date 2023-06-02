import 'package:flutter/material.dart';

class FollowChip extends StatelessWidget {
  const FollowChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.blue, borderRadius: BorderRadius.circular(25)),
      child: const Row(
        children: [
          Icon(Icons.add, color: Colors.white, size: 20),
          SizedBox(width: 2),
          Text(
            "Follow",
            style: TextStyle(color: Colors.white, fontSize: 14),
          )
        ],
      ),
    );
  }
}
