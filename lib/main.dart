import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/bloc_observer.dart';
import 'application/post_bloc/post_bloc.dart';
import 'application/post_bloc/post_event.dart';
import 'domain/repositories/post_repository.dart';
import 'infrastructure/data_ providers/post_data_provider.dart';
import 'presentation/routes/app_route_config.dart';

void main() {
  final PostRepository postRepository = PostRepository(PostDataProvider());

  BlocOverrides.runZoned(
    () => runApp(
      MultiBlocProvider(providers: [
        BlocProvider<PostBloc>(
          create: (context) => PostBloc(postRepository: postRepository),
        ),
        // BlocProvider<PostBloc>(
        //   create: (context) => PostBloc(postRepository: postRepository),
        // ),
        // Add other bloc providers if needed
      ], child: MyApp(postRepository: postRepository)),
    ),
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final PostRepository postRepository;
  const MyApp({Key? key, required this.postRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: postRepository,
      child: BlocProvider<PostBloc>(
        create: (context) => PostBloc(postRepository: postRepository)
          ..add(const PostLoadEvent()),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routeInformationParser:
              NyAppRouter.returnRouter(false).routeInformationParser,
          routerDelegate: NyAppRouter.returnRouter(false).routerDelegate,
        ),
      ),
    );
  }
}

