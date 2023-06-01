import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:picstash/application/comment_bloc/comment_blocs.dart';
import 'package:picstash/application/comment_bloc/comment_state.dart';
import 'package:unicons/unicons.dart';
import '../../application/comment_bloc/comment_event.dart';
import '../components/comment_box.dart';

class CommentScreen extends StatefulWidget {
  final String id;
  final String username;
  final String name;
  final String title;
  final String description;
  final String avatarUrl;
  final String date;
  final String imageUrl;
  // final likes;
  // final dislikes;
  // final comments;

  const CommentScreen({
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
  State<CommentScreen> createState() => _CommentScreenWidgetState();
}

class _CommentScreenWidgetState extends State<CommentScreen> {
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

  List<String> likes = [];
  List<String> dislikes = [];
  List<dynamic> comments = [];
  var res;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentBloc, CommentState>(
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
          likes = [];
          for (var obj in state.props) {
            for (var i in obj[0]) {
              likes.add(i);
            }
          }
        } else if (state is CommentDisLikeSuccess) {
          dislikes = [];
          for (var obj in state.props) {
            for (var i in obj[0]) {
              dislikes.add(i);
            }
          }
        } else if (state is CommentedSuccess) {
          comments = [];
          for (var obj in state.props) {
            for (var i in obj[0]) {
              comments.add(i);
            }
          }
        } else if (state is PostCommentLoaded) {
          likes = [];
          dislikes = [];
          comments = [];
          for (var obj in state.props) {
            for (var i in obj[0]) {
              likes.add(i);
            }
            for (var i in obj[1]) {
              dislikes.add(i);
            }
            for (var i in obj[2]) {
              comments.add(i);
            }
          }
          res = commentBuilder(comments);
        }
      }),
      builder: (context, state) {
        switch (state.runtimeType) {
          case CommentLoadingState:
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
            return Scaffold(
              appBar: AppBar(
                title: const Text('Comments'),
                leading: IconButton(
                  onPressed: () {
                    GoRouter.of(context).pop(context);
                  },
                  icon: const Icon(UniconsLine.arrow_left),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
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
                              .copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w600)),
                      subtitle: Text(widget.username,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("test", //widget.comments[0][0],
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.grey)),
                        ],
                      ),
                    ),
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
                                  BlocProvider.of<CommentBloc>(context).add(
                                      AddLike(
                                          id: widget.id,
                                          userName: widget.username));
                                },
                                icon: likes.contains(widget.username)
                                    ? const Icon(
                                        UniconsLine.thumbs_up,
                                        color: Colors.blue,
                                      )
                                    : Icon(UniconsLine.thumbs_up,
                                        color:
                                            Theme.of(context).iconTheme.color)),
                            IconButton(
                                onPressed: () {
                                  BlocProvider.of<CommentBloc>(context).add(
                                      AddDisLike(widget.id, widget.username));
                                },
                                icon: dislikes.contains(widget.username)
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
                            onPressed: () {},
                            icon: Icon(
                              UniconsLine.share_alt,
                              color: Theme.of(context).iconTheme.color,
                            ))
                      ],
                    ),
                    Column(
                      children: res,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(widget.avatarUrl),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: InputDecoration(
                            hintText: 'Add a comment',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.grey)),
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
                        ))
                  ],
                ),
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
                            GoRouter.of(context).pop();
                          },
                          child: const Text("Go Back")),
                    )
                  ]),
            );
        }
      },
    );
  }
}
