import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstash/presentation/screens/error_page.dart';
import '../../application/post_bloc/post_bloc.dart';
import '../../infrastructure/factory models/post_factory.dart';
import '../components/post2.dart';

class ShowPosts extends StatelessWidget {
  final String username;
  const ShowPosts({required this.username, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
        bloc: BlocProvider.of<PostBloc>(context),
        builder: (BuildContext context, state) {
          if (state is PostLoadingState) {
            BlocProvider.of<PostBloc>(context).add(const PostLoadEvent());
            return Center(
              child: CircularProgressIndicator(
                color: Colors.blueGrey[50],
              ),
            );
          } else if (state is PostOperationSuccess) {
            final posts = state.posts as List;
            List<Post> userPosts = [];
            for (var post in posts) {
              if (post.author == username) {
                userPosts.add(post);
              }
            }
            return userPosts.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, idx) {
                      return PostWidget2(
                        id: userPosts[idx].id,
                        avatarUrl: userPosts[idx].authorAvatar,
                        username: userPosts[idx].author,
                        date: userPosts[idx].createdAt,
                        imageUrl: userPosts[idx].sourceURL,
                        likes: userPosts[idx].likes,
                        dislikes: userPosts[idx].dislikes,
                        comments: userPosts[idx].comments,
                        description: userPosts[idx].description,
                        name: userPosts[idx].authorName,
                        title: userPosts[idx].title,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: userPosts.length)
                : const Center(
                    child: Text(
                      "No posts to show",
                      style: TextStyle(color: Colors.black),
                    ),
                  );
          } else {
            return const ErrorPage();
          }
        });
  }
}
