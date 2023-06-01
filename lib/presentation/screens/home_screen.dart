import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/post_bloc/post_bloc.dart';
import '../../domain/repositories/post_repository.dart';
import '../../infrastructure/data_providers/post_data_provider.dart';
import '../components/post2.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    postBloc.add(const PostLoadEvent());
    super.initState();
  }

  final PostBloc postBloc =
      PostBloc(postRepository: PostRepository(PostDataProvider()));
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
        bloc: postBloc,
        builder: (BuildContext context, state) {
          if (state is PostLoadingState) {
            return const Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: CircularProgressIndicator(),
                ));
          } else if (state is PostOperationSuccess) {
            final posts = state.posts as List;
            return Scaffold(
                body: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (_, idx) => PostWidget_2(
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
              ),
            ));
          } else if (state is PostOperationFailure) {
            return const Scaffold(body: Center(child: Text('Error')));
          } else {
            return const SizedBox();
          }
        });
  }
}
