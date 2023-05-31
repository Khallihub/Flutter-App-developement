// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:flutter_svg/svg.dart';
import 'package:unicons/unicons.dart';

import '../../application/post_bloc/post_bloc.dart';
import '../../application/post_bloc/post_event.dart';
import '../../application/post_bloc/post_state.dart';
import '../../domain/repositories/post_repository.dart';
import '../../infrastructure/data_ providers/post_data_provider.dart';
import '../components/comment_box.dart';
// import 'comment_box.dart';

class CommentScreen_2 extends StatefulWidget {
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

  const CommentScreen_2({
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
  State<CommentScreen_2> createState() => _CommentScreenWidgetState();
}

class _CommentScreenWidgetState extends State<CommentScreen_2> {
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

        print("jaldjfaldfjaldfjadlfjdfaldj ");

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
          print("asfjd;jdfaldjfaldfjkd ${[likes, dislikes, comments]}");
        }
        var res = commentBuilder(comments);

        int no_likes = likes.length;
        int no_dislikes = dislikes.length;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
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
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Y2F0fGVufDB8fDB8fHww&auto=format&fit=crop&w=500&q=60'),
                          fit: BoxFit.cover)),
                ),
              ),
              const SizedBox(height: 10),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Container(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 12, vertical: 8),
              //       decoration: BoxDecoration(
              //           color: Colors.blue,
              //           borderRadius: BorderRadius.circular(25)),
              //       child: const Text('Schedule a meeting',
              //           style: TextStyle(color: Colors.white, fontSize: 14)),
              //     ),
              //     Container(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 12, vertical: 8),
              //       decoration: BoxDecoration(
              //           color: Colors.grey.withOpacity(0.1),
              //           borderRadius: BorderRadius.circular(25)),
              //       child: const Text('Send a message',
              //           style: TextStyle(color: Colors.black, fontSize: 14)),
              //     ),
              //     Container(
              //       padding: const EdgeInsets.symmetric(
              //           horizontal: 12, vertical: 8),
              //       decoration: BoxDecoration(
              //           color: Colors.grey.withOpacity(0.1),
              //           borderRadius: BorderRadius.circular(25)),
              //       child: const Text('Details',
              //           style: TextStyle(color: Colors.black, fontSize: 14)),
              //     )
              //   ],
              // ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
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
                        '${widget.description} • thus ',
                        style:
                            const TextStyle(fontSize: 12, color: Colors.grey),
                      )
                    ],
                  ),
                  const Spacer(),
                  // Container(
                  //   height: 25,
                  //   alignment: Alignment.center,
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(25),
                  //       color: Colors.grey.withOpacity(0.1)),
                  //   child: Text(
                  //     widget.name,
                  //     style:
                  //         const TextStyle(fontSize: 14, color: Colors.blue),
                  //   ),
                  // ),
                  const SizedBox(width: 5),
                  const Icon(Icons.more_vert)
                ],
              ),
              const SizedBox(height: 10),
              Text(widget.description),
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
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
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
                  ),
                  Text('$no_likes'),
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
                          : Icon(
                              UniconsLine.thumbs_down,
                            )),
                  Text('$no_dislikes'),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "All Comments",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Container(
                child: Column(
                  children: res
                      .map((comment) => Padding(
                            padding: EdgeInsets.symmetric(
                                vertical:
                                    5), // Add 10 pixels of vertical padding
                            child: comment,
                          ))
                      .toList(),
                ),
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
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
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
                            postBloc.add(PostCommentedEvent(
                                widget.id, widget.username, comment));
                            _commentController.text = "";
                            postBloc.add(SinglePostLoadedEvent(widget.id));
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

              // ListView.separated(
              //     shrinkWrap: true,
              //     physics: const NeverScrollableScrollPhysics(),
              //     itemBuilder: (context, index) {
              //       return Container(
              //         padding: const EdgeInsets.all(10),
              //         decoration: BoxDecoration(
              //             color: Colors.grey.withOpacity(0.1),
              //             borderRadius: BorderRadius.circular(10)),
              //         child: Column(
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Row(
              //               children: [
              //                 Container(
              //                   height: 30,
              //                   width: 30,
              //                   decoration: BoxDecoration(
              //                       borderRadius: BorderRadius.circular(5),
              //                       image: DecorationImage(
              //                           image: NetworkImage(
              //                               'https://picsum.photos/200/300'),
              //                           fit: BoxFit.cover)),
              //                 ),
              //                 const SizedBox(width: 10),
              //                 const Text(
              //                   "Steve John • ",
              //                   style: TextStyle(fontWeight: FontWeight.w600),
              //                 ),
              //                 const Text("5m ago")
              //               ],
              //             ),
              //             const SizedBox(height: 10),
              //             Text(widget.description),
              //             const SizedBox(height: 10),
              //             // Row(
              //             //   children: [
              //             //     SvgPicture.asset(CustomAssets.kHeart),
              //             //     const SizedBox(width: 2),
              //             //     Text('likenumber'),
              //             //   ],
              //             // )
              //           ],
              //         ),
              //       );
              //     },
              //     separatorBuilder: (context, index) =>
              //         const SizedBox(height: 10),
              //     itemCount: 2)
            ],
          ),
        );
      },
    );
  }
}
