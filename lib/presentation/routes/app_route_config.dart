import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:picstash/application/chat_bloc/blocs.dart';
import 'package:picstash/domain/repositories/chat_repository.dart';
import 'package:picstash/infrastructure/data_providers/chat_data_provider.dart';
import '../../application/post_bloc/post_bloc.dart';
import '../../domain/entities/dummy_profile_data.dart';
import '../../domain/repositories/post_repository.dart';
import '../../infrastructure/data_providers/post_data_provider.dart';
import '../components/chat/search_screen.dart';
import '../screens/chat_list_screen.dart';
import '../screens/chat_screen.dart';
import '../screens/comment_screen2.dart';
import '../screens/home_screen.dart';
import '../screens/login_page.dart';
import '../screens/signup_page.dart';
import '../screens/user_profile_screen.dart';
import 'app_route_constants.dart';

class MyAppRouter {
  static GoRouter returnRouter(bool isLoggedIn) {
    GoRouter router = GoRouter(
      // initialLocation: isLoggedIn ? "/home" : "/login",
      // initialLocation: "/profile",
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: isLoggedIn ? const Home() : const LogIn());
          },
        ),
        GoRoute(
          name: MyAppRouteConstants.loginRouteName,
          path: "/login",
          pageBuilder: (context, state) {
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
            path: "/profile",
            pageBuilder: ((context, state) {
              return MaterialPage(
                child: UserProfileScreen(
                  userProfile: DummyProfile.getUserProfile(),
                  isOwner: false,
                ),
              );
            })),
        GoRoute(
          name: MyAppRouteConstants.commentRoutName,
          path:
              '/comment/:id/:username/:name/:title/:description/:avatarUrl/:date/:imageUrl',
          pageBuilder: (context, state) {
            return MaterialPage(
              child: BlocProvider(
                create: (context) => PostBloc(
                    postRepository: PostRepository(PostDataProvider())),
                child: CommentScreen_2(
                  id: state.pathParameters['id'] as String,
                  username: state.pathParameters['username'] as String,
                  name: state.pathParameters['name'] as String,
                  title: state.pathParameters['title'] as String,
                  description: state.pathParameters['description'] as String,
                  avatarUrl: state.pathParameters['avatarUrl'] as String,
                  date: state.pathParameters['date'] as String,
                  imageUrl: state.pathParameters['imageUrl'] as String,
                ),
              ),
            );
          },
        ),
        GoRoute(
          name: MyAppRouteConstants.chatRouteName,
          path: '/chat/:id/:user1/:user2/:friendImage/:friendName',
          pageBuilder: (context, state) {
            // print('p'*99) ;
            // print(state.pathParameters['id'] as String);
            // print(state.pathParameters['user1'] as String);
            // print(state.pathParameters['user2'] as String);
            // print(state.pathParameters['friendImage'] as String);
            // print(state.pathParameters['friendName'] as String);
            return MaterialPage(
                child: BlocProvider(
              create: (context) =>
                  ChatBloc(chatRepository: ChatRepository(ChatDataProvider())),
              child: ChatScreen(
                id: state.pathParameters['id'] as String,
                user1: state.pathParameters['user1'] as String,
                user2: state.pathParameters['user2'] as String,
                friendImage: state.pathParameters['friendImage'] as String,
                friendName: state.pathParameters['friendName'] as String,
              ),
            ));
          },
        ),
        GoRoute(
          name: MyAppRouteConstants.chatListRouteName,
          path: '/chatlist',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: BlocProvider(
              create: (context) =>
                  ChatBloc(chatRepository: ChatRepository(ChatDataProvider())),
              child: ChatListScreen(),
            ));
          },
        ),
        GoRoute(
          name: MyAppRouteConstants.chatScreenSearch,
          path: '/chatscreensearch',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: BlocProvider(
              create: (context) =>
                  ChatBloc(chatRepository: ChatRepository(ChatDataProvider())),
              child: SearchScreen(),
            ));
          },
        ),
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
