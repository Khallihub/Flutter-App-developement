import 'package:flutter/material.dart';
import 'package:picstash/application/post_bloc/blocs.dart';
import 'package:unicons/unicons.dart';

import '../../domain/repositories/post_repository.dart';
import '../../infrastructure/data_ providers/post_data_provider.dart';

class CommentScreen extends StatefulWidget {
  final String id;
  final String username;
  final String name;
  final String title;
  final String description;
  final String avatarUrl;
  final String date;
  final String imageUrl;
  final likes;
  final dislikes;
  final comments;

  const CommentScreen({
    super.key,
    required this.id,
    required this.avatarUrl,
    required this.username,
    required this.date,
    required this.imageUrl,
    required this.likes,
    required this.dislikes,
    required this.comments,
    required this.name,
    required this.title,
    required this.description,
  });

  @override
  State<CommentScreen> createState() => _CommentScreenWidgetState();
}

class _CommentScreenWidgetState extends State<CommentScreen> {
  bool more = false;
  final PostBloc postBloc =
      PostBloc(postRepository: PostRepository(PostDataProvider()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(widget.avatarUrl),
            ),
            title: Text(widget.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 15, fontWeight: FontWeight.w600)),
            subtitle: Text(widget.username,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey)),
            trailing: IconButton(
              onPressed: () {
                setState(() {
                  more = !more;
                });
              },
              icon: Icon(
                Icons.more_horiz,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          ),
          more == true
              ? Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.comments[0],
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colors.grey)),
                    ],
                  ),
                )
              : const SizedBox(),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              widget.imageUrl,
              height: 200,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        postBloc.add(PostLikedEvent(widget.id, widget.username));
                      },
                      icon: Icon(UniconsLine.thumbs_up,
                          color: Theme.of(context).iconTheme.color)),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(UniconsLine.comment_lines,
                          color: Theme.of(context).iconTheme.color)),
                  IconButton(
                      onPressed: () {
                        postBloc.add(PostDislikedEvent(widget.id, widget.username));
                      },
                      icon: Icon(UniconsLine.thumbs_down,
                          color: Theme.of(context).iconTheme.color))
                ],
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    UniconsLine.share_alt,
                    color: Theme.of(context).iconTheme.color,
                  ))
            ],
          )
        ],
      ),
    );
  }
}
