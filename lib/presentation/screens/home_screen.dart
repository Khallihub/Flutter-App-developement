import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:picstash/presentation/components/post.dart';

import '../../application/post_bloc/blocs.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   title: const Text('Home'),
        // ),
        body: BlocBuilder<PostBloc, PostState>(
          builder: (_, state) {
            if (kDebugMode) {
              print('state: $state');
            }
            if (state is PostOperationFailure) {
              if (kDebugMode) {
                print('post operation failure');
              }
              return const Center(
                child: Text('Could not do post operation'),
              );
            }
            if (state is PostOperationSuccess) {
              if (kDebugMode) {
                print('post operation success');
              }
              final posts = state.posts.toList();
              return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (_, idx) => PostWidget(
                  avatarUrl: "http", //posts[idx].authorAvatar,
                  username: posts[idx].author,
                  date: posts[idx].createdAt,
                  imageUrl: "temp",//posts[idx].sourceUrl,
                  likes: posts[idx].likes.length,
                  dislikes: posts[idx].dislikes.length,
                  comments: posts[idx].comments.length,
                  description: posts[idx].description,
                  name: posts[idx].author,
                  title: posts[idx].title,
                ),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
