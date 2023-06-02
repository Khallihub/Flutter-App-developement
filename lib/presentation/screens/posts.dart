import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstash/presentation/screens/error_page.dart';
import '../../application/post_bloc/post_bloc.dart';
import '../../domain/entities/dummy_post.dart';
import '../components/post2.dart';

class ShowPosts extends StatelessWidget {
  const ShowPosts({super.key});

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
            return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, idx) {
                  return PostWidget2(
                    id: posts[idx].id,
                    avatarUrl: posts[idx].authorAvatar,
                    username: posts[idx].author,
                    date: posts[idx].createdAt,
                    imageUrl: posts[idx].sourceURL,
                    likes: posts[idx].likes,
                    dislikes: posts[idx].dislikes,
                    comments: posts[idx].comments,
                    description: posts[idx].description,
                    name: posts[idx].authorName,
                    title: posts[idx].title,
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: dummyPosts.length);
          } else {
            return const ErrorPage();
          }
        });
  }
}
