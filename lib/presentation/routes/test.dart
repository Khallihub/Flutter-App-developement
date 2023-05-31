import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unicons/unicons.dart';

import '../../application/post_bloc/post_blocs.dart';
import '../../application/post_bloc/post_event.dart';
import '../../application/post_bloc/post_state.dart';
import '../components/comment_box.dart';

class MyWidget extends StatefulWidget {
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
  const MyWidget({
    super.key,
    required this.id,
    required this.username,
    required this.name,
    required this.title,
    required this.description,
    required this.avatarUrl,
    required this.date,
    required this.imageUrl,
    // this.likes,
    // this.dislikes,
  });

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late PostBloc postBloc;

  bool more = false;

  final TextEditingController _commentController = TextEditingController();
  @override
  void initState() {
    postBloc = BlocProvider.of<PostBloc>(context);
    postBloc.add(PostCommentLoadedEvent(widget.id));
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        var comments = [];
        for (var comm in state.props) {
          for (var comment in comm) {
            comments.add(comment);
          }
        }
        var res = commentBuilder(comments);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Comments'),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(UniconsLine.arrow_left),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              ListTile(
                title: Text(widget.username),
              ),
              ListTile(
                title: Text(widget.name),
              ),
              ListTile(
                title: Text(widget.id),
              ),
              ListTile(
                title: Text(widget.avatarUrl),
              ),
              ListTile(
                title: Text(widget.title),
              ),
              ListTile(
                title: Text(widget.description),
              ),
              ListTile(
                title: Text(widget.date),
              ),
              ListTile(
                title: Text(widget.imageUrl),
              ),
              // ListTile(
              //   title: Text(widget.likes.toString()),
              // ),
              // ListTile(
              //   title: Text(widget.dislikes.toString()),
              // ),
              ...res,
            ]),
          ),
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Expanded(
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage("widget.avatarUrl"),
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
                      postBloc.add(PostCommentedEvent(
                          widget.id, "widget.username", comment));
                      _commentController.text = "";
                      postBloc.add(PostCommentLoadedEvent(widget.id));
                    }
                  },
                  icon: Icon(
                    UniconsLine.arrow_right,
                    color: Theme.of(context).iconTheme.color,
                  ))
            ],
          ),
        );
      },
    );
  }
}
