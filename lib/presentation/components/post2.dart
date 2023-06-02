import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:picstash/presentation/routes/app_route_constants.dart';
import 'package:picstash/presentation/screens/error_page.dart';
import 'package:unicons/unicons.dart';

import '../../application/post_bloc/post_blocs.dart';
import '../../application/post_bloc/post_event.dart';
import '../../domain/entities/login/login_details.dart';
import '../../infrastructure/data_providers/db/db.dart';

class PostWidget2 extends StatefulWidget {
  final String id;
  final String username;
  final String name;
  final String title;
  final String description;
  final String avatarUrl;
  final String date;
  final String imageUrl;
  final List<dynamic> likes;
  final List<dynamic> dislikes;
  final List<dynamic> comments;

  const PostWidget2({
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
  State<PostWidget2> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget2> {
  late PostBloc postBloc;

  @override
  void initState() {
    postBloc = BlocProvider.of(context);
    super.initState();
  }

  bool more = false;

  void goComments(snapshot, context) {
    GoRouter.of(context)
        .pushNamed(MyAppRouteConstants.commentRoutName, pathParameters: {
      "id": widget.id,
      "username": snapshot.data!.localUserModel.username,
      "name": widget.username,
      "title": widget.title,
      "description": widget.description,
      "avatarUrl": widget.avatarUrl,
      "date": widget.date,
      "imageUrl": widget.imageUrl,
    });
  }

  Future<LoginDetailsModel?> fetchLocalUser() async {
    LoginCredentials loginCredentials = LoginCredentials();
    return await loginCredentials.getLoginCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchLocalUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            int noLikes = widget.likes.length;
            int noDislikes = widget.dislikes.length;
            int noComments = widget.comments.length;
            DateTime postDate = DateTime.fromMillisecondsSinceEpoch(
                int.parse(widget.date) * 1000);
            return InkWell(
              onTap: () {
                goComments(snapshot, context);
              },
              child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(children: [
                    Row(
                      children: [
                        Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: NetworkImage(widget.avatarUrl),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${widget.username} • ${postDate.year} - ${postDate.month} - ${postDate.day}',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            )
                          ],
                        ),
                        const Spacer(),
                        const SizedBox(width: 5),
                        const Icon(Icons.more_vert),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(widget.description)),
                    const SizedBox(height: 5),
                    Hero(
                      tag: widget.id,
                      child: Container(
                        height: MediaQuery.of(context).size.width * 0.65,
                        width: double.maxFinite,
                        alignment: Alignment.topRight,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(widget.imageUrl),
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
                    Row(children: [
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
                          color: Colors.white,
                          onPressed: () {
                            BlocProvider.of<PostBloc>(context).add(
                                PostLikedEvent(widget.id,
                                    snapshot.data!.localUserModel.username));
                          },
                        ),
                      ),
                      Text(
                        '$noLikes',
                        style: const TextStyle(color: Colors.black),
                      ),
                      IconButton(
                        icon: const Icon(UniconsLine.thumbs_down),
                        color: Colors.white,
                        onPressed: () {
                          BlocProvider.of<PostBloc>(context).add(
                              PostDislikedEvent(widget.id,
                                  snapshot.data!.localUserModel.username));
                        },
                      ),
                      Text(
                        '$noDislikes',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          goComments(snapshot, context);
                        },
                        icon: const Icon(UniconsLine.comment_lines,
                            color: Colors.white),
                      ),
                      Text(
                        '$noComments',
                        style: const TextStyle(color: Colors.black),
                      ),
                    ])
                  ])),
            );
          }
          return const ErrorPage();
        });
  }
}
