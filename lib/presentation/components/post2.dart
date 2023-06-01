import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:picstash/presentation/routes/app_route_constants.dart';
import 'package:unicons/unicons.dart';

import '../../application/post_bloc/post_blocs.dart';
import '../../application/post_bloc/post_event.dart';
import '../../domain/entities/login/login_details.dart';
import '../../infrastructure/data_providers/db/db.dart';

class PostWidget_2 extends StatefulWidget {
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

  const PostWidget_2({
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
  State<PostWidget_2> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget_2> {
  late PostBloc postBloc;

  @override
  void initState() {
    postBloc = BlocProvider.of(context);
    super.initState();
  }

  bool more = false;

  Future<LoginDetailsModel?> fetchLocalUser() async {
    LoginCredentials loginCredentials = LoginCredentials();
    return await loginCredentials.getLoginCredentials();
  }

  @override
  Widget build(BuildContext context) {
    int noLikes = widget.likes.length;
    int noDislikes = widget.dislikes.length;
    int noComments = widget.comments.length;

    return FutureBuilder(
        future: fetchLocalUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return InkWell(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: const DecorationImage(
                                  image: NetworkImage(
                                      'https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y2F0fGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60'),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.username,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${widget.description} • ${widget.description}',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            )
                          ],
                        ),
                        const Spacer(),
                        const SizedBox(width: 5),
                        const Icon(Icons.more_vert)
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(widget.description),
                    const SizedBox(height: 5),
                    Hero(
                      tag: widget.id,
                      child: Container(
                        height: 160,
                        width: double.maxFinite,
                        alignment: Alignment.topRight,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                                image: NetworkImage(
                                    'https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y2F0fGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60'),
                                fit: BoxFit.cover)),
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.black.withOpacity(0.05),
                          ),
                          child:
                              const Icon(Icons.attachment, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: IconButton(
                                icon: const Icon(UniconsLine.thumbs_up),
                                color:
                                    Colors.black, // Set the color of the icon
                                onPressed: () {
                                  BlocProvider.of<PostBloc>(context).add(
                                      PostLikedEvent(
                                          widget.id,
                                          snapshot
                                              .data!.localUserModel.username));
                                },
                              ),
                            ),
                            Text(
                              '$noLikes',
                              style: const TextStyle(color: Colors.black),
                            ),
                            IconButton(
                              icon: const Icon(UniconsLine.thumbs_down),
                              color: Colors.black,
                              onPressed: () {
                                BlocProvider.of<PostBloc>(context).add(
                                    PostDislikedEvent(
                                        widget.id,
                                        snapshot
                                            .data!.localUserModel.username));
                              },
                            ),
                            Text(
                              '$noDislikes',
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                GoRouter.of(context).pushNamed(
                                    MyAppRouteConstants.commentRoutName,
                                    pathParameters: {
                                      "id": widget.id,
                                      "username": snapshot
                                          .data!.localUserModel.username,
                                      "name": widget.username,
                                      "title": widget.title,
                                      "description": widget.description,
                                      "avatarUrl": widget.avatarUrl,
                                      "date": widget.date,
                                      "imageUrl": widget.imageUrl,
                                    });
                              },
                              icon: const Icon(UniconsLine.comment_lines,
                                  color: Colors.black),
                            ),
                            Text(
                              '$noComments',
                              style: const TextStyle(color: Colors.black),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          return const Text("allahu akber");
        });
  }
}
