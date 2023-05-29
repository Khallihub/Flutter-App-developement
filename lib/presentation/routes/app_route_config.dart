import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:picstash/presentation/screens/login_page.dart';
import 'package:picstash/presentation/screens/signup_page.dart';
import '../screens/comment_screen.dart';
import 'app_route_constants.dart';

class MyAppRouter {
  static GoRouter returnRouter(bool isAuth) {
    GoRouter router = GoRouter(
      initialLocation: MyAppRouteConstants.loginRouteName,
      routes: [
        GoRoute(
          name: MyAppRouteConstants.loginRouteName,
          path: '/',
          pageBuilder: (context, state) {
            return const MaterialPage(child: MyRegister());
          },
        ),
        GoRoute(
          path: "/login",
          pageBuilder: (context, state) {
            print('p' * 99);
            return const MaterialPage(child: LogIn());
          },
        ),
        GoRoute(
            name: MyAppRouteConstants.signupRouteName,
            path: "/register",
            pageBuilder: ((context, state) {
              return const MaterialPage(child: MyRegister());
            })),
        GoRoute(
          name: MyAppRouteConstants.commentRoutName,
          path:
              '/comment/:id/:title/:username/:name/:description/:avatarUrl/:date/:imageUrl/:likes/:dislikes/:comments',
          pageBuilder: (context, state) {
            final likes = state.pathParameters['likes']!.split('`');
            final dislikes = state.pathParameters['dislikes']!.split('`');
            final comments = state.pathParameters['comments']!.split('`');
            return MaterialPage(
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
              comments: comments,
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
