import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:picstash/presentation/screens/error_page.dart';
import 'package:unicons/unicons.dart';
import '../../application/comment_bloc/comment_blocs.dart';
import '../../application/comment_bloc/comment_event.dart';
import '../../application/comment_bloc/comment_state.dart';
import '../components/post2.dart';

class CommentScreen2 extends StatefulWidget {
  final String id;
  final String username;
  final String name;
  final String title;
  final String description;
  final String avatarUrl;
  final String date;
  final String imageUrl;

  const CommentScreen2({
    Key? key,
    required this.id,
    required this.avatarUrl,
    required this.username,
    required this.date,
    required this.imageUrl,
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

  List<dynamic> likes = [];
  List<dynamic> dislikes = [];
  List<dynamic> res = [];

  @override
  void initState() {
    BlocProvider.of<CommentBloc>(context)
        .add(LoadPostCommentEvent(id: widget.id));
    super.initState();
  }

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
          } else if (state is PostCommentLoaded) {
            likes = state.props[0]["likes"];
            dislikes = state.props[0]["dislikes"];
            res = state.props[0]["comments"];
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
                        GoRouter.of(context).pop();
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
                        margin: const EdgeInsets.only(top: 10),
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
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, top: 5),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.indigoAccent,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(widget.avatarUrl),
                              radius: 28,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 5),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "@${widget.name}",
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      "${postDate.year} - ${postDate.month} - ${postDate.day}",
                                      style: const TextStyle(
                                          letterSpacing: 1,
                                          fontSize: 10,
                                          color: Colors.black),
                                    )
                                  ],
                                ),
                              ]),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(widget.description)),
                    const SizedBox(height: 10),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SpecialIcon(
                            val: likes.length.toString(),
                            iconData: Icons.thumb_up,
                            color: likes.contains(widget.username)
                                ? Colors.green
                                : Colors.indigo,
                            doFunction: () {
                              BlocProvider.of<CommentBloc>(context).add(AddLike(
                                  id: widget.id, userName: widget.username));
                            },
                          ),
                          SpecialIcon(
                            val: dislikes.length.toString(),
                            iconData: Icons.thumb_down,
                            color: dislikes.contains(widget.username)
                                ? Colors.red
                                : Colors.indigo,
                            doFunction: () {
                              BlocProvider.of<CommentBloc>(context)
                                  .add(AddDisLike(widget.id, widget.username));
                            },
                          ),
                        ]),
                    const Text(
                      "All Comments",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 400,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: ((context, index) {
                          return Container(
                              decoration: BoxDecoration(
                                color: Colors.indigo,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 22,
                                        backgroundColor: Colors.white,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              (res[index][0][0])["avatar"]),
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            res[index][0][0]["Name"],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ))
                                    ],
                                  ),
                                  const Divider(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                  Text(
                                    res[index][1],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                ],
                              ));
                        }),
                        itemCount: res.length,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomCenter,
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
                                  maxLines: null,
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
                                      comment: comment,
                                    ),
                                  );
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
              return const ErrorPage();
          }
        });
  }
}
