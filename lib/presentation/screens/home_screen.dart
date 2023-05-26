import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/post_bloc/blocs.dart';
import '../../domain/repositories/post_repository.dart';
import '../../infrastructure/data_ providers/post_data_provider.dart';
import '../components/post.dart';

class Home extends StatefulWidget {
  const Home({super.key});

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
    return BlocConsumer<PostBloc, PostState>(
      bloc: postBloc,
      // listenWhen: (previous, current) => current is PostLoadingState,
      // buildWhen: (previous, current) => current is !PostLoadingState,
      listener: (BuildContext context, Object? state) {
        if (state is PostLikedActionState) {
          // postBloc.add(PostLikedEvent(widget.id, widget.post));
        } else if (state is PostDislikedActionState) {
          // todo
        } else if (state is PostCommentedActionState) {
          // todo
        } else if (state is PostSharedActionState) {
          // todo
        }
      },
      builder: (BuildContext context, state) {
        switch (state.runtimeType) {
          case PostLoadingState:
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          case PostOperationSuccess:
            final posts = state.props[0] as List;
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
          case PostOperationFailure:
            return const Scaffold(body: Center(child: Text('Error')));
          default:
            return const SizedBox();
        }
      },
    );
  }
}

