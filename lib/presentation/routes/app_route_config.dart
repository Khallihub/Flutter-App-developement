import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:picstash/domain/entities/user_profile/user_profile.dart';
import 'package:picstash/presentation/screens/edit_profile_screen.dart';
import 'package:picstash/presentation/screens/screens.dart';
import '../../application/chat_bloc/chat_bloc.dart';
import '../../domain/repositories/chat_repository.dart';
import '../../infrastructure/data_providers/chat_data_provider.dart';
import '../screens/chat_search.dart';
import '../screens/search_screen.dart';
import '../screens/chat_list_screen.dart';
import '../screens/comment_screen2.dart';
import '../screens/login_page.dart';
import '../screens/error_page.dart';
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
          name: MyAppRouteConstants.homeRouteName,
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
            name: MyAppRouteConstants.userProfile,
            path: "/profile/:username/:bio/:avatar/:id/:name/:email/:role",
            pageBuilder: ((context, state) {
              UserProfile userProfile = UserProfile(
                  id: state.pathParameters["id"] as String,
                  name: state.pathParameters["name"] as String,
                  email: state.pathParameters["email"] as String,
                  userName: state.pathParameters["username"] as String,
                  avatar: state.pathParameters["avatar"] as String,
                  bio: state.pathParameters["bio"] as String,
                  role: "user");
              return MaterialPage(
                child: UserProfileScreen(
                  userProfile: userProfile,
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
                child: CommentScreen2(
              id: state.pathParameters['id'] as String,
              avatarUrl: state.pathParameters['avatarUrl'] as String,
              username: state.pathParameters['username'] as String,
              name: state.pathParameters['name'] as String,
              title: state.pathParameters['title'] as String,
              description: state.pathParameters['description'] as String,
              date: state.pathParameters['date'] as String,
              imageUrl: state.pathParameters['imageUrl'] as String,
            ));
          },
        ),
        GoRoute(
          name: MyAppRouteConstants.chatRouteName,
          path: '/chat/:id/:user1/:user2/:friendImage/:friendName',
          pageBuilder: (context, state) {
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
            name: MyAppRouteConstants.editProfileRouteName,
            path: "/edit_profile",
            pageBuilder: ((context, state) {
              return const MaterialPage(child: EditProfileScreen());
            })),
        GoRoute(
          name: MyAppRouteConstants.notImplemented,
          path: "/not_implemented",
          pageBuilder: (context, state) {
            return const MaterialPage(child: ErrorPage());
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
              child: const ChatListScreen(),
            ));
          },
        ),
        GoRoute(
          name: MyAppRouteConstants.chatScreenSearch,
          path: '/chatscreensearch/:localUser',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: BlocProvider(
              create: (context) =>
                  ChatBloc(chatRepository: ChatRepository(ChatDataProvider())),
              child: ChatSearchScreen(
                  localUser: state.pathParameters["localUser"]),
            ));
          },
        ),
        GoRoute(
          name: MyAppRouteConstants.searchScreen,
          path: '/chatscreensearch/:localUser',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: BlocProvider(
              create: (context) =>
                  ChatBloc(chatRepository: ChatRepository(ChatDataProvider())),
              child: SearchScreen(localUser: state.pathParameters["localUser"]),
            ));
          },
        ),
      ],
    );
    return router;
  }
}
