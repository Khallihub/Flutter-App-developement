import 'package:flutter/material.dart';


class CommentBox extends StatefulWidget {
  final String username;
  final String comment;

  const CommentBox({
    super.key,
    required this.username,
    required this.comment,
  });

  @override
  State<CommentBox> createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1621574533977-4b3b1b0b0b0b?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZmFtaWx5JTIwcG9zdHxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80'),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.username,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  widget.comment,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}
