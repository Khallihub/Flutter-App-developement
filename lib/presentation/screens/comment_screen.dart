import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstash/application/post_bloc/blocs.dart';
import 'package:unicons/unicons.dart';

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
  late PostBloc postBloc;

  bool more = false;
  // final PostBloc postBloc =
  //     PostBloc(postRepository: PostRepository(PostDataProvider()));
  final TextEditingController _commentController = TextEditingController();
  @override
  void initState() {
    postBloc = BlocProvider.of<PostBloc>(context);
    postBloc.add(SinglePostLoadedEvent(widget.id));
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
        var likes = [];
        var dislikes = [];
        var comments = [];
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
                          .copyWith(fontSize: 15, fontWeight: FontWeight.w600)),
                  subtitle: Text(widget.username,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                              postBloc.add(PostCommentLikedEvent(
                                  widget.id, widget.username));
                              postBloc.add(SinglePostLoadedEvent(widget.id));
                            },
                            icon: likes.contains(widget.username)
                                ? const Icon(
                                    UniconsLine.thumbs_up,
                                    color: Colors.blue,
                                  )
                                : Icon(UniconsLine.thumbs_up,
                                    color: Theme.of(context).iconTheme.color)),
                        IconButton(
                            onPressed: () {
                              postBloc.add(PostCommentDislikedEvent(
                                  widget.id, widget.username));
                              postBloc.add(SinglePostLoadedEvent(widget.id));
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
                  //   // widget.comments.length,
                  //   state.props.length,
                  //   (index) => CommentBox(
                  //       username: state.props[index] ,//widget.comments[index]
                  //           // .toString()
                  //           // .split(",")[0]
                  //           // .toString()
                  //           // .substring(1),
                  //       comment: state.props[index] as String, //widget.comments[index]
                  //           // .toString()
                  //           // .split(",")[1]
                  //           // .toString()
                  //           // .substring(
                  //           //     0,
                  //           //     state.props[index]//widget.comments[index]
                  //           //             .toString()
                  //           //             .split(",")[1]
                  //           //             .toString()
                  //           //             .length -
                  //           //         1
                  //           //         )
                  //                   ),
                  // ),
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
                        postBloc.add(PostCommentedEvent(
                            widget.id, widget.username, comment));
                        _commentController.text = "";
                        postBloc.add(SinglePostLoadedEvent(widget.id));
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
      },
    );
  }
}
