import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:picstash/application/post_bloc/post_bloc.dart';
import 'package:picstash/presentation/routes/app_route_constants.dart';
import 'package:unicons/unicons.dart';

class PostWidget extends StatefulWidget {
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

  const PostWidget({
    Key? key,
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
  }) : super(key: key);

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late PostBloc postBloc;

  @override
  void initState() {
    postBloc = BlocProvider.of(context);
    super.initState();
  }

  bool more = false;
  @override
  Widget build(BuildContext context) {
    return Column(
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
                    Text(widget.description,
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
                    icon: widget.likes.contains(widget.username)
                        ? const Icon(
                            UniconsLine.thumbs_up,
                            color: Colors.blue,
                          )
                        : Icon(UniconsLine.thumbs_up,
                            color: Theme.of(context).iconTheme.color)),
                IconButton(
                    onPressed: () {
                      GoRouter.of(context).pushNamed(
                        MyAppRouteConstants.commentRoutName,
                        pathParameters: {
                          "id": widget.id,
                          "username": widget.username,
                          "name": widget.name,
                          "title": widget.title,
                          "description": widget.description,
                          "avatarUrl": widget.avatarUrl,
                          "date": widget.date,
                          "imageUrl": widget.imageUrl,
                        },
                      );
                    },
                    icon: Icon(UniconsLine.comment_lines,
                        color: Theme.of(context).iconTheme.color)),
                IconButton(
                    onPressed: () {
                      postBloc
                          .add(PostDislikedEvent(widget.id, widget.username));
                    },
                    icon: widget.dislikes.contains(widget.username)
                        ? const Icon(
                            UniconsLine.thumbs_down,
                            color: Colors.red,
                          )
                        : const Icon(
                            UniconsLine.thumbs_down,
                          ))
              ],
            ),
            IconButton(
                onPressed: () {
                  GoRouter.of(context).pushNamed(
                    MyAppRouteConstants.chatRouteName,
                    pathParameters: {
                      "user1": widget.username,
                      "user2": widget.name
                    },
                  );
                },
                icon: Icon(
                  UniconsLine.share_alt,
                  color: Theme.of(context).iconTheme.color,
                ))
          ],
        )
      ],
    );
  }
}
