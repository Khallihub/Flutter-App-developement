import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../application/post_bloc/post_bloc.dart';
import '../../domain/repositories/post_repository.dart';
import '../../infrastructure/data_ providers/post_data_provider.dart';
import '../screens/comment_screen.dart';
import '../screens/home_screen.dart';
import 'app_route_constants.dart';

class NyAppRouter {
  static GoRouter returnRouter(bool isAuth) {
    GoRouter router = GoRouter(
      routes: [
        GoRoute(
          name: MyAppRouteConstants.homeRouteName,
          path: '/',
          pageBuilder: (context, state) {
            return const MaterialPage(child: Home());
          },
        ),
        GoRoute(
          name: MyAppRouteConstants.commentRoutName,
          path:
              '/comment/:id/:title/:username/:name/:description/:avatarUrl/:date/:imageUrl/:likes/:dislikes', //:comments',
          pageBuilder: (context, state) {
            // print('kdddddddddddddddddddddddddddddddddddddddddddddddddddddddddd');
            final likes = state.pathParameters['likes']!.split('`');
            final dislikes = state.pathParameters['dislikes']!.split('`');
            // String temp = state.pathParameters['comments']!;
            // List<String> temp1 = temp.split("`");
            // var comments = [];
            // for (int i = 0; i < temp1.length; i += 1) {
            //   comments.add([temp1[i]]);
            // }

            return MaterialPage(
                child: BlocProvider(
              create: (context) =>
                  PostBloc(postRepository: PostRepository(PostDataProvider())),
              child: CommentScreen(
                id: state.pathParameters['id']!,
                title: state.pathParameters['title']!,
                username: state.pathParameters['username']!,
                name: state.pathParameters['name']!,
                description: state.pathParameters['description']!,
                avatarUrl: state.pathParameters['avatarUrl']!,
                date: state.pathParameters['date']!,
                imageUrl: state.pathParameters['imageUrl']!,
                likes: likes,
                dislikes: dislikes,
                // comments: comments,
              ),
            ));
          },
        ),
        // GoRoute(
        //   name: MyAppRouteConstants.aboutRouteName,
        //   path: '/about',
        //   pageBuilder: (context, state) {
        //     return MaterialPage(child: About());
        //   },
        // ),
        // GoRoute(
        //   name: MyAppRouteConstants.contactUsRouteName,
        //   path: '/contact_us',
        //   pageBuilder: (context, state) {
        //     return MaterialPage(child: ContactUS());
        //   },
        // )
      ],
      // errorPageBuilder: (context, state) {
      //   return MaterialPage(child: ErrorPage());

      // redirect: (context, state) {
      //   if (!isAuth &&
      //       state.location
      //           .startsWith('/${MyAppRouteConstants.profileRouteName}')) {
      //     return context.namedLocation(MyAppRouteConstants.contactUsRouteName);
      //   } else {
      //     return null;
      //   }
      // },
    );
    return router;
  }
}
