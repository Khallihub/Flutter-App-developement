// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// import 'application/bloc_observer.dart';
// import 'application/post_bloc/blocs.dart';
// import 'domain/repositories/post_repository.dart';
// import 'infrastructure/data_ providers/post_data_provider.dart';
// import 'presentation/screens/home_screen.dart';

// void main() {
//   final postRepository = PostRepository(
//     PostDataProvider(),
//   );
//   BlocOverrides.runZoned(
//     () => runApp(
//       MultiBlocProvider(
//         providers: [
//           BlocProvider<PostBloc>(
//             create: (context) => PostBloc(postRepository: postRepository),
//           ),
//           // Add other bloc providers if needed
//         ],
//         child: MyApp(
//           postRepository: postRepository,
//         ),
//       ),
//     ),
//     blocObserver: SimpleBlocObserver(),
//   );
// }

// late final PostRepository postRepository;

// final GoRouter _router = GoRouter(
//   routes: <RouteBase>[
//     GoRoute(
//       path: '/',
//       builder: (BuildContext context, GoRouterState state) {
//         return MyApp(postRepository: postRepository);
//       },
//       routes: <RouteBase>[
//         GoRoute(
//           path: 'home',
//           builder: (BuildContext context, GoRouterState state) {
//             return const Home();
//           },
//         ),
//       ],
//     ),
//   ],
// );

// class MyApp extends StatelessWidget {
//   final PostRepository postRepository;

//   const MyApp({super.key, required this.postRepository});

//   @override
//   Widget build(BuildContext context) {
//     return RepositoryProvider.value(
//       value: postRepository,
//       child: BlocProvider(
//         create: (context) => PostBloc(postRepository: postRepository)
//           ..add(const PostLoadEvent()),
//         child: MaterialApp(
//           debugShowCheckedModeBanner: false,
//           theme: ThemeData(primaryColor: Colors.teal),
//           home: const Home(),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'presentation/routes/app_route_config.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser:
          NyAppRouter.returnRouter(false).routeInformationParser,
      routerDelegate: NyAppRouter.returnRouter(false).routerDelegate,
    );
  }
}
