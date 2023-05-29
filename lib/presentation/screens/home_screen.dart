import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/post_bloc/blocs.dart';
// import '../../domain/repositories/post_repository.dart';
// import '../../infrastructure/data_ providers/post_data_provider.dart';
import '../components/post.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  // void initState() {
  //   postBloc.add(const PostLoadEvent());
  //   super.initState();
  // }

  // final PostBloc postBloc =
  //     PostBloc(postRepository: PostRepository(PostDataProvider()));
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
        builder: (BuildContext context, state) {
      if (state is PostLoadingState) {
        return const Scaffold(
            body: Center(
          child: CircularProgressIndicator(),
        ));
      } else if (state is PostOperationSuccess) {
        final posts = state.posts as List;
        return Scaffold(
            body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (_, idx) => PostWidget(
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
