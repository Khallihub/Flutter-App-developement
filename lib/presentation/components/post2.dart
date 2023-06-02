import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:picstash/presentation/routes/app_route_constants.dart';
import 'package:picstash/presentation/screens/error_page.dart';
import '../../application/post_bloc/post_blocs.dart';
import '../../application/post_bloc/post_event.dart';
import '../../domain/entities/login/login_details.dart';
import '../../infrastructure/data_providers/db/db.dart';

class SpecialIcon extends StatelessWidget {
  const SpecialIcon(
      {Key? key,
      required this.val,
      required this.iconData,
      required this.color,
      required this.doFunction})
      : super(key: key);
  final String val;
  final Color color;
  final IconData iconData;
  final VoidCallback doFunction;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, top: 5),
      child: InkWell(
        onTap: doFunction,
        child: Row(
          children: [
            Icon(
              iconData,
              color: color,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(val),
            ),
          ],
        ),
      ),
    );
  }
}

class PstWidget extends StatefulWidget {
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

  const PstWidget({
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
  State<PstWidget> createState() => _PstWidgetState();
}

class _PstWidgetState extends State<PstWidget> {
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
          DateTime postDate = DateTime.fromMillisecondsSinceEpoch(
              int.parse(widget.date) * 1000);
          return Column(children: [
            Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigoAccent.withOpacity(0.25),
                      blurRadius: 20,
                      spreadRadius: 1,
                    ),
                  ],
                  //border: Border.all(color: kaccentColor.withOpacity(0.2), width: 2),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white),
              margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: Row(
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
                                  widget.name,
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
                                      "@${widget.username} •  ${postDate.year} - ${postDate.month} - ${postDate.day}",
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
                  ),
                  const SizedBox(
                    height: 10,
                    child: Divider(color: Colors.black38),
                  ),
                  widget.title.isEmpty
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5),
                          child: Text(
                            widget.title,
                            style: const TextStyle(fontSize: 19),
                          ),
                        ),
                  Hero(
                    tag: widget.id,
                    child: Container(
                      height: MediaQuery.of(context).size.width * 0.75,
                      width: double.maxFinite,
                      alignment: Alignment.topRight,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(widget.imageUrl),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: Text(
                      widget.description,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                    child: Divider(color: Colors.black38),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SpecialIcon(
                          val: widget.comments.length.toString(),
                          iconData: Icons.comment_outlined,
                          color: Colors.indigo,
                          doFunction: () {
                            goComments(snapshot, context);
                          },
                        ),
                        SpecialIcon(
                          val: widget.likes.length.toString(),
                          iconData: Icons.thumb_up,
                          color: widget.likes.contains(
                                  snapshot.data!.localUserModel.username)
                              ? Colors.green
                              : Colors.indigo,
                          doFunction: () {
                            BlocProvider.of<PostBloc>(context).add(
                                PostLikedEvent(widget.id,
                                    snapshot.data!.localUserModel.username));
                          },
                        ),
                        SpecialIcon(
                          val: widget.dislikes.length.toString(),
                          iconData: Icons.thumb_down,
                          color: widget.dislikes.contains(
                                  snapshot.data!.localUserModel.username)
                              ? Colors.red
                              : Colors.indigo,
                          doFunction: () {
                            BlocProvider.of<PostBloc>(context).add(
                                PostDislikedEvent(widget.id,
                                    snapshot.data!.localUserModel.username));
                          },
                        ),
                      ]),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ]);
        } else {
          int i = 0;
          while (i <= 5) {
            Future.delayed(const Duration(seconds: 2));
            i++;
          }
          return const ErrorPage();
        }
      },
    );
  }
}
