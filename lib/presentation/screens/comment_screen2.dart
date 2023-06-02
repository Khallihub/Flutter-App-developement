// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:unicons/unicons.dart';

import '../../application/comment_bloc/comment_blocs.dart';
import '../../application/comment_bloc/comment_event.dart';
import '../../application/comment_bloc/comment_state.dart';
import '../components/comment_box.dart';
import '../routes/app_route_constants.dart';

class CommentScreen2 extends StatefulWidget {
  final String id;
  final String username;
  final String name;
  final String title;
  final String description;
  final String avatarUrl;
  final String date;
  final String imageUrl;
  // final int likes;
  // final int dislikes;
  // final comments;

  const CommentScreen2({
    Key? key,
    required this.id,
    required this.avatarUrl,
    required this.username,
    required this.date,
    required this.imageUrl,
    // required this.likes,
    // required this.dislikes,
    // required this.comments,
    required this.name,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  State<CommentScreen2> createState() => _CommentScreenWidgetState();
}

class _CommentScreenWidgetState extends State<CommentScreen2> {
  bool more = false;
  final TextEditingController _commentController = TextEditingController();

  List<Widget> commentBuilder(List comments) {
    List<Widget> commentList = [];
    for (int i = 0; i < comments.length; i += 1) {
      commentList.add(CommentBox(
        username: comments[i][0],
        comment: comments[i][1],
      ));
    }
    return commentList;
  }

  List<dynamic> likes = [];
  List<dynamic> dislikes = [];
  List<dynamic> res = [];
  List<Widget> commentWidget = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentBloc, CommentState>(
        bloc: BlocProvider.of<CommentBloc>(context),
        listener: ((context, state) {
          if (state is CommentInitialState) {
            BlocProvider.of<CommentBloc>(context)
                .add(LoadPostCommentEvent(id: widget.id));
          } else if (state is CommentFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    "something went wrong, unable to perform the selected operation"),
              ),
            );
          } else if (state is CommentLikedSuccess) {
            likes = state.props[0];
            dislikes = state.props[1];
          } else if (state is CommentDisLikeSuccess) {
            likes = state.props[0];
            dislikes = state.props[1];
          } else if (state is CommentedSuccess) {
            res = state.props[0];
            commentWidget = commentBuilder(res);
          } else if (state is PostCommentLoaded) {
            likes = state.props[0]["likes"];
            dislikes = state.props[0]["dislikes"];
            res = state.props[0]["comments"];
            commentWidget = commentBuilder(res);
          }
        }),
        builder: (context, state) {
          if (state is CommentInitialState) {
            BlocProvider.of<CommentBloc>(context)
                .add(LoadPostCommentEvent(id: widget.id));
          }

          switch (state.runtimeType) {
            case CommentLoadingState:
            case PostCommentLoading:
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case PostCommentLoaded:
            case LoadedPostComments:
            case CommentedSuccess:
            case CommentLikedSuccess:
            case CommentDisLikeSuccess:
              DateTime postDate = DateTime.fromMillisecondsSinceEpoch(
                  int.parse(widget.date) * 1000);
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.grey[900],
                  elevation: 0,
                  leading: IconButton(
                      color: Colors.grey[200],
                      onPressed: () {
                        GoRouter.of(context).pop(context);
                      },
                      icon: const Icon(UniconsLine.arrow_left)),
                ),
                body: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  children: [
                    Hero(
                      tag: widget.id,
                      child: Container(
                        height: 400,
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(widget.imageUrl),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    const SizedBox(height: 30),
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
                              '${widget.username} •  ${postDate.year} - ${postDate.month} - ${postDate.day}',
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const SizedBox(width: 5),
                        const Icon(Icons.more_vert)
                      ],
                    ),
                    const SizedBox(height: 10),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(widget.description)),
                    const SizedBox(height: 10),
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
                            onPressed: () {
                              BlocProvider.of<CommentBloc>(context).add(AddLike(
                                  id: widget.id, userName: widget.username));
                            },
                            icon: const Icon(UniconsLine.thumbs_up),
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${likes.length}",
                          style: const TextStyle(color: Colors.white),
                        ),
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<CommentBloc>(context)
                                .add(AddDisLike(widget.id, widget.username));
                          },
                          icon: const Icon(UniconsLine.thumbs_down),
                          color: Colors.white,
                        ),
                        Text(
                          '${dislikes.length}',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "All Comments",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: ((context, index) {
                        return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey[700],
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  widget.avatarUrl),
                                              fit: BoxFit.cover)),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                          '${widget.username} • ${postDate.year} - ${postDate.month} - ${postDate.day} ',
                                          style: const TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ])
                                ]));
                      }),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 10),
                      itemCount: 2,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[200],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: TextField(
                                  style: const TextStyle(
                                    color: Colors.black,
                                  ),
                                  controller: _commentController,
                                  maxLines:
                                      null, // Allow the TextField to expand vertically
                                  decoration: InputDecoration(
                                    hintText: 'Add a comment',
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.grey[500],
                                        ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                var comment = _commentController.text;
                                if (comment != "") {
                                  BlocProvider.of<CommentBloc>(context).add(
                                      AddCommentEvent(
                                          id: widget.id,
                                          username: widget.username,
                                          comment: comment));
                                  _commentController.text = "";
                                }
                              },
                              icon: Icon(
                                UniconsLine.arrow_right,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            default:
              return Scaffold(
                body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(child: Text("something wrong happend")),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              GoRouter.of(context).pushReplacementNamed(
                                  MyAppRouteConstants.homeRouteName);
                            },
                            child: const Text("Go Back")),
                      )
                    ]),
              );
          }
        });
  }
}
