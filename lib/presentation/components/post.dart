import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {
  final String username;
  final String name;
  final String title;
  final String description;
  final String avatarUrl;
  final String date;
  final String imageUrl;
  final int likes;
  final int dislikes;
  final int comments;

  const PostWidget({super.key, 
    required this.avatarUrl,
    required this.username,
    required this.date,
    required this.imageUrl,
    required this.likes,
    required this.dislikes,
    required this.comments, required this.name, required this.title, required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(avatarUrl),
                radius: 20.0,
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Image.network(imageUrl),
          const SizedBox(height: 10.0),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.thumb_up),
                onPressed: () {
                  // Add like functionality
                },
              ),
              Text('$likes'),
              IconButton(
                icon: const Icon(Icons.thumb_down),
                onPressed: () {
                  // Add dislike functionality
                },
              ),
              Text('$dislikes'),
              IconButton(
                icon: const Icon(Icons.comment),
                onPressed: () {
                  // Add comment functionality
                },
              ),
              Text('$comments'),
            ],
          ),
        ],
      ),
    );
  }
}
